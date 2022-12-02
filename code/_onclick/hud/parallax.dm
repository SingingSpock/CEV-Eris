GLOBAL_VAR_INIT(random_parallax, pick("space0", "space1", "space2", "space3", "space4", "space5", "space6"))

/obj/parallax
	icon = 'icons/parallax.dmi'
	icon_state = "space0"
	name = "parallax"
	mouse_opacity = 0
	blend_mode = BLEND_MULTIPLY
	plane = PLANE_SPACE_PARALLAX
	anchored = TRUE
	var/mob/owner

/obj/parallax/New(mob/M)
	owner = M
	owner.parallax += src
	update()
	..(null)

/obj/parallax/Destroy()
	owner = null
	return ..()

/obj/parallax/proc/update() //This proc updates your parallax (duh). If your view has been altered by binoculars, admin fuckery, and so on. We need to make the space bigger by applying a matrix transform to it. This is hardcoded for now.
	if(!owner || !owner.client)
		return
	var/turf/T = get_turf(owner.client.eye)
	if(!T)
		return
	screen_loc = "CENTER:[-224-T.x],CENTER:[-224-T.y]"
	//And now we change depending on what is happening in processing events
	for(var/datum/event/E in SSevent.active_events)
		switch(E.storyevent.id)
			if("bluespace_interphase")
				icon_state = "bluespace_interphase"
			if("graveyard")
				icon_state = "graveyard"
			if("bluespace_storm")
				icon_state = "bluespace_storm"
			if("ion_blizzard")
				icon_state = "ion_blizzard"
				//no close layer here
			if("photon_vortex")
				icon_state = "photon_vortex"
			if("micro_debris")
				icon_state = "micro_debris"
			if("nebula")
				icon_state = "nebula"
			else
				icon_state = GLOB.random_parallax
		continue //Only one event changes our state, priority should be from up to down if there are multiple
	var/matrix/M = matrix()	//create matrix for transformation
	if(owner.client.view != world.view)	//Not bigger than world view. We don't need transforming
		var/toscale = owner.client.view	//How many extra tiles we need to fill with parallax. EG. Their view is 8. World view is 7. So one extra tile is needed.
		switch(owner.client.view)
			if(8)
				toscale = 1.2
			if(9)
				toscale = 1.4
			if(10)
				toscale = 1.6
			if(11)
				toscale = 1.8
			if(12)
				toscale = 2
			if(13)
				toscale = 2.2
			if(14)
				toscale = 2.4
			if(128)
				toscale = 4
		M.Scale(toscale)
	else
		M.Scale(1)
	transform = M

/obj/parallax/update_plane()
	return

/obj/parallax/set_plane(var/np)
	plane = np


/mob
	var/obj/parallax/parallax

/mob/Move(NewLoc, Dir = 0, step_x = 0, step_y = 0, var/glide_size_override = 0)
	. = ..()
	if(. && parallax)
		parallax.update()

/mob/forceMove(atom/destination, var/special_event, glide_size_override=0)
	. = ..()
	if(. && parallax)
		parallax.update()


/mob/Login()
	if(!parallax)
		parallax = new(src)
	client.screen += parallax
	..()
