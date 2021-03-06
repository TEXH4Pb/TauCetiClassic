/obj/item/weapon/hand_labeler
	name = "hand labeler"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "labeler0"
	item_state = "flight"
	m_amt = 800
	origin_tech = "materials=1"
	var/label = null
	var/labels_left = 30
	var/mode = 0	//off or on.

/obj/item/weapon/hand_labeler/afterattack(atom/A, mob/user, proximity)
	if(!proximity) return
	if(!mode)	//if it's off, give up.
		return
	if(A == loc)	// if placing the labeller into something (e.g. backpack)
		return		// don't set a label

	if(!labels_left)
		to_chat(user, "<span class='notice'>No labels left.</span>")
		return
	if(!label || !length(label))
		to_chat(user, "<span class='notice'>No text set.</span>")
		return
	if(length(A.name) + length(label) > 64)
		to_chat(user, "<span class='notice'>Label too big.</span>")
		return
	if(ishuman(A))
		to_chat(user, "<span class='notice'>You can't label humans.</span>")
		return
	if(issilicon(A))
		to_chat(user, "<span class='notice'>You can't label cyborgs.</span>")
		return
	if(istype(A, /obj/item/weapon/reagent_containers/glass))
		to_chat(user, "<span class='notice'>The label can't stick to the [A.name].  (Try using a pen)</span>")
		return

	user.visible_message("<span class='notice'>[user] labels [A] as [label].</span>", \
						 "<span class='notice'>You label [A] as [label].</span>")
	A.name = "[A.name] ([label])"

/obj/item/weapon/hand_labeler/attack_self(mob/user)
	mode = !mode
	icon_state = "labeler[mode]"
	if(mode)
		to_chat(user, "<span class='notice'>You turn on \the [src].</span>")
		//Now let them chose the text.
		var/str = sanitize_safe(input(user,"Label text?","Set label",""),MAX_NAME_LEN)
		if(!str || !length(str))
			to_chat(user, "<span class='notice'>Invalid text.</span>")
			return
		label = str
		to_chat(user, "<span class='notice'>You set the text to '[str]'.</span>")
	else
		to_chat(user, "<span class='notice'>You turn off \the [src].</span>")
