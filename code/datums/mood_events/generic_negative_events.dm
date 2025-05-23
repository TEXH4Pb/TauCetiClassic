/datum/mood_event/naked
	description = "<span class='warning'>I am naked... And the worst part, people are noticing it!</span>"
	mood_change = -10
	timeout = 1 MINUTE

/datum/mood_event/dirty_clothes
	description = "<span class='warning'>I don't like wearing dirty clothes...</span>"
	mood_change = -1

/datum/mood_event/dirty_clothes/add_effects(_mood_change)
	mood_change = _mood_change

/datum/mood_event/wet_clothes
	description = "<span class='warning'>I don't like wearing wet clothes...</span>"
	mood_change = -1

/datum/mood_event/wet_clothes/add_effects(_mood_change)
	mood_change = _mood_change

// ipc and other synths
/datum/mood_event/dangerous_clothes
	description = "<span class='warning'>I am pretty sure these wet clothes are dangerous to me...</span>"
	mood_change = -2

/datum/mood_event/dangerous_clothes/add_effects(_mood_change)
	mood_change = _mood_change

// skrells and dionaea I guess
/datum/mood_event/refreshing_clothes
	description = "<span class='nicegreen'>Ah yes, nothing better than refreshing, wet clothes!</span>"
	mood_change = 1

/datum/mood_event/refreshing_clothes/add_effects(_mood_change)
	mood_change = _mood_change

/datum/mood_event/self_tending
	description = "<span class='warning'>I had to tend my own wounds, is there nobody else to help me?</span>"
	mood_change = -3
	timeout = 1 MINUTE

/datum/mood_event/scared
	description = "<span class='warning'>I'm scared.</span>"
	mood_change = -2
	timeout = 1 MINUTE

/datum/mood_event/nasty_throat_feel
	description = "<span class='warning'>Something stuck in my throat.</span>"
	mood_change = -3
	timeout = 3 MINUTE
