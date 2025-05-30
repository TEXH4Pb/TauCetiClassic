#define INVISIBILITY_NONE 0

#define SEE_INVISIBLE_MINIMUM 5

#define SEE_INVISIBLE_OBSERVER_NOLIGHTING 15

#define INVISIBILITY_LIGHTING 20

#define SEE_INVISIBLE_LIVING  25

#define SEE_INVISIBLE_LEVEL_ONE 35
#define INVISIBILITY_LEVEL_ONE  35

#define SEE_INVISIBLE_LEVEL_TWO 45
#define INVISIBILITY_LEVEL_TWO  45

#define SEE_INVISIBLE_CULT    60
#define INVISIBILITY_OBSERVER 60

#define SEE_INVISIBLE_OBSERVER 61
#define INVISIBILITY_AI_EYE    61

#define INVISIBILITY_MAXIMUM  100 // the maximum allowed for "real" objects
#define INVISIBILITY_ABSTRACT 101 // only used for abstract objects (e.g. spacevine_controller), things that are not really there.

//Some mob defines below
#define AI_CAMERA_LUMINOSITY 6

#define BORGMESON 1
#define BORGTHERM 2
#define BORGXRAY  4
#define BORGNIGHT 8
#define BORGIGNORESIGHT 16

//Consider these images/atoms as part of the UI/HUD
#define APPEARANCE_UI                  RESET_COLOR|RESET_TRANSFORM|NO_CLIENT_COLOR
#define APPEARANCE_UI_IGNORE_ALPHA     APPEARANCE_UI|RESET_ALPHA
