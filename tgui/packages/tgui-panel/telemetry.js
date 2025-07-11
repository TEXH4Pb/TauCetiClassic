/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { storage } from 'common/storage';
import { createLogger } from 'tgui/logging';

const logger = createLogger('telemetry');

const MAX_CONNECTIONS_STORED = 10;

const decoder = decodeURIComponent || unescape;

const getOldCookie = (cname) => {
  let name = 'tau-' + cname + '=';
  let ca = document.cookie.split(';');
  for (let i = 0, c; i < ca.length; i++) {
    c = ca[i];
    while (c.charAt(0) === ' ') c = c.substring(1);
    if (c.indexOf(name) === 0) {
      return decoder(c.substring(name.length, c.length));
    }
  }
  return null;
};

const getOldConnections = () => {
  let dataCookie = getOldCookie('connData');
  if (dataCookie) {
    try {
      return JSON.parse(dataCookie).map((item) => ({
        ckey: item.ckey,
        address: item.ip,
        computer_id: item.compid,
      }));
    } catch {}
  }
  return [];
};

const connectionsMatch = (a, b) =>
  a.ckey === b.ckey &&
  a.address === b.address &&
  a.computer_id === b.computer_id;

export const telemetryMiddleware = (store) => {
  let telemetry;
  let wasRequestedWithPayload;
  return (next) => (action) => {
    const { type, payload } = action;
    // Handle telemetry requests
    if (type === 'telemetry/request') {
      // Defer telemetry request until we have the actual telemetry
      if (!telemetry) {
        logger.debug('deferred');
        wasRequestedWithPayload = payload;
        return;
      }
      logger.debug('sending');
      const limits = payload?.limits || {};
      // Trim connections according to the server limit
      const charset = document.defaultCharset;
      const connections = telemetry.connections.slice(0, limits.connections);
      const localTime = new Date().getTimezoneOffset() * -60;
      const pixelRatio = window.devicePixelRatio;
      Byond.sendMessage({
        type: 'telemetry',
        payload: {
          charset,
          connections,
          localTime,
          pixelRatio,
        },
      });
      return;
    }
    // Keep telemetry up to date
    if (type === 'backend/update') {
      next(action);
      (async () => {
        // Extract client data
        const client = payload?.config?.client;
        if (!client) {
          logger.error('backend/update payload is missing client data!');
          return;
        }
        // Load telemetry
        if (!telemetry) {
          telemetry = (await storage.get('telemetry')) || {};
          if (!telemetry.connections) {
            telemetry.connections = getOldConnections();
          }
          logger.debug('retrieved telemetry from storage', telemetry);
        }
        // Append a connection record
        let telemetryMutated = false;
        const duplicateConnection = telemetry.connections.find((conn) =>
          connectionsMatch(conn, client)
        );
        if (!duplicateConnection) {
          telemetryMutated = true;
          telemetry.connections.unshift(client);
          if (telemetry.connections.length > MAX_CONNECTIONS_STORED) {
            telemetry.connections.pop();
          }
        }
        // Save telemetry
        if (telemetryMutated) {
          logger.debug('saving telemetry to storage', telemetry);
          storage.set('telemetry', telemetry);
        }
        // Continue deferred telemetry requests
        if (wasRequestedWithPayload) {
          const payload = wasRequestedWithPayload;
          wasRequestedWithPayload = null;
          store.dispatch({
            type: 'telemetry/request',
            payload,
          });
        }
      })();
      return;
    }
    return next(action);
  };
};
