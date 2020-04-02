#define SENTRY_FIREANGLE 	135
#define SENTRY_RANGE 		7
#define SENTRY_MUZZLELUM	3
/obj/structure/machinery/defenses/sentry
	name = "\improper UA 571-C sentry gun"
	desc = "A deployable, semi-automated turret with AI targeting capabilities. Armed with an M30 Autocannon and a 500-round drum magazine."
	req_one_access = list(ACCESS_MARINE_ENGINEERING, ACCESS_MARINE_ENGPREP, ACCESS_MARINE_LEADER)
	var/list/atom/movable/targets = list() // Lists of current potential targets
	var/list/other_targets = list() //List of special target types to shoot at, if needed.
	var/list/obj/effect/turret_trigger/turret_triggers = list()
	var/atom/movable/target = null
	var/datum/effect_system/spark_spread/spark_system //The spark system, used for generating... sparks?
	var/obj/structure/machinery/camera/camera = null
	var/last_fired = 0
	var/fire_delay = 6
	var/immobile = FALSE //Used for prebuilt ones.
	var/obj/item/ammo_magazine/ammo = new /obj/item/ammo_magazine/sentry
	var/sentry_type = "sentry" //Used for the icon

/obj/structure/machinery/defenses/sentry/Initialize()
	. = ..()
	spark_system = new /datum/effect_system/spark_spread
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)
	camera = new (src)
	camera.network = list("military")
	camera.c_tag = "[name] ([rand(0, 1000)])"
	if(turned_on)
		create_turret_triggers()
	update_icon()

/obj/structure/machinery/defenses/sentry/update_icon()
	..()

	overlays.Cut()
	if(stat == DEFENSE_DAMAGED)
		overlays += "uac_[sentry_type]_destroyed"
		return

	if(!ammo || ammo && !ammo.current_rounds)
		overlays += "uac_[sentry_type]_noammo"
		return
	if(turned_on)
		overlays += "uac_[sentry_type]_on"
	else
		overlays += "uac_[sentry_type]"

/obj/structure/machinery/defenses/sentry/attack_hand(mob/user as mob)
	if(immobile)
		to_chat(user, SPAN_WARNING("[src]'s panel is completely locked, you can't do anything."))
		return

	..()

/obj/structure/machinery/defenses/sentry/examine(mob/user)
	. = ..()
	if(ammo)
		to_chat(user, SPAN_NOTICE("[src] has [ammo.current_rounds]/[ammo.max_rounds] rounds loaded."))
	else
		to_chat(user, SPAN_NOTICE("[src] is empty and needs to be refilled with ammo."))

/obj/structure/machinery/defenses/sentry/power_on_action()
	target = null
	SetLuminosity(7)
	if(!camera)
		camera = new /obj/structure/machinery/camera(src)
		camera.network = list("military")
		camera.c_tag = src.name

	visible_message("[htmlicon(src, viewers(src))] [SPAN_NOTICE("The [name] hums to life and emits several beeps.")]")
	visible_message("[htmlicon(src, viewers(src))] [SPAN_NOTICE("The [name] buzzes in a monotone voice: 'Default systems initiated'")]")
	create_turret_triggers()

/obj/structure/machinery/defenses/sentry/power_off_action()
	visible_message("[htmlicon(src, viewers(src))] [SPAN_NOTICE("The [name] powers down and goes silent.")]")
	delete_turret_triggers()

/obj/structure/machinery/defenses/sentry/attackby(var/obj/item/O, var/mob/user)
	if(isnull(O) || isnull(user)) 
		return

	//Securing/Unsecuring
	if(iswrench(O))
		if(immobile)
			to_chat(user, SPAN_WARNING("[src] is completely welded in place. You can't move it without damaging it."))
			return

	if(!..())
		return

	// Rotation
	if(isscrewdriver(O))
		if(immobile)
			to_chat(user, SPAN_WARNING("[src] is completely welded in place. You can't move it without damaging it."))
			return

		if(turned_on)
			to_chat(user, SPAN_WARNING("[src] is currently active. The motors will prevent you from rotating it safely."))
			return

		playsound(loc, 'sound/items/Screwdriver.ogg', 25, 1)
		user.visible_message(SPAN_NOTICE("[user] rotates [src]."), SPAN_NOTICE("You rotate [src]."))
		if(dir == NORTH)
			dir = EAST
		else if(dir == EAST)
			dir = SOUTH
		else if(dir == SOUTH)
			dir = WEST
		else if(dir == WEST)
			dir = NORTH
		return

	if(istype(O, ammo))
		var/obj/item/ammo_magazine/M = O
		if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_PLASTEEL) || user.action_busy)
			return

		if(ammo.current_rounds)
			to_chat(user, SPAN_WARNING("You only know how to swap [M.name] when it's empty."))
			return

		user.visible_message(SPAN_NOTICE("[user] begins swapping a new [O.name] into [src]."),
		SPAN_NOTICE("You begin swapping a new [O.name] into [src]."))
		if(!do_after(user, 70, INTERRUPT_ALL, BUSY_ICON_FRIENDLY, src))
			return

		playsound(loc, 'sound/weapons/unload.ogg', 25, 1)
		user.visible_message(SPAN_NOTICE("[user] swaps a new [O.name] into [src]."),
		SPAN_NOTICE("You swap a new [O.name] into [src]."))

		ammo = O
		user.drop_held_item(O)
		O.loc = src
		update_icon()
		return

	if(O.force)
		update_health(O.force/2)
	return ..()

/obj/structure/machinery/defenses/sentry/destroyed_action()
	visible_message("[htmlicon(src, viewers(src))] [SPAN_WARNING("The [name] starts spitting out sparks and smoke!")]")
	playsound(loc, 'sound/mecha/critdestrsyndi.ogg', 25, 1)
	for(var/i = 1 to 6)
		dir = pick(NORTH, EAST, SOUTH, WEST)
		sleep(2)

	cell_explosion(loc, 10, 10, null, "sentry explosion")
	if(!disposed)
		qdel(src)

/obj/structure/machinery/defenses/sentry/damaged_action(var/damage)
	if(prob(10))
		spark_system.start()
	..()

/obj/structure/machinery/defenses/sentry/proc/create_turret_triggers()
	for(var/turf/T in orange(src, SENTRY_RANGE))
		for(var/atom/movable/A in T)
			if((isliving(A) && !isrobot(A)) || (A.type in other_targets))
				targets.Add(A)
		turret_triggers.Add(new /obj/effect/turret_trigger(T, src))

/obj/structure/machinery/defenses/sentry/proc/delete_turret_triggers()
	targets = list()
	for(var/obj/effect/turret_trigger/T in turret_triggers)
		turret_triggers.Remove(T)
		qdel(T)

/obj/structure/machinery/defenses/sentry/proc/fire(var/atom/A)
	if(!(world.time-last_fired >= fire_delay) || !turned_on || !ammo || isnull(target))
		return

	if(world.time-last_fired >= 300) //if we haven't fired for a while, beep first
		playsound(loc, 'sound/machines/twobeep.ogg', 50, 1)
		sleep(3)

	if(ammo && ammo.current_rounds <= 0)
		to_chat(usr, SPAN_WARNING("[name] does not have any ammo."))
		return

	last_fired = world.time

	if(isnull(owner_mob))
		owner_mob = src

	actual_fire(A)

	if(targets.len)
		add_timer(CALLBACK(src, .proc/get_target), fire_delay)
	
/obj/structure/machinery/defenses/sentry/proc/actual_fire(var/atom/A)
	var/obj/item/projectile/P = new(initial(name), owner_mob)
	P.generate_bullet(new ammo.default_ammo)
	P.fire_at(A, src, owner_mob, P.ammo.max_range, P.ammo.shell_speed)
	muzzle_flash(Get_Angle(get_turf(src), A))
	ammo.current_rounds--
	if(ammo.current_rounds == 0)
		visible_message("[htmlicon(src, viewers(src))] <span class='warning'>The [name] beeps steadily and its ammo light blinks red.</span>")
		playsound(loc, 'sound/weapons/smg_empty_alarm.ogg', 25, 1)
		update_icon()

//Mostly taken from gun code.
/obj/structure/machinery/defenses/sentry/proc/muzzle_flash(var/angle)
	if(isnull(angle)) 
		return

	SetLuminosity(SENTRY_MUZZLELUM)
	add_timer(CALLBACK(src, /atom/proc/SetLuminosity, -SENTRY_MUZZLELUM), 10)

	var/image_layer = layer + 0.1
	var/offset = 13

	var/image/I = image('icons/obj/items/weapons/projectiles.dmi',src,"muzzle_flash",image_layer)
	var/matrix/rotate = matrix() //Change the flash angle.
	rotate.Translate(0, offset)
	rotate.Turn(angle)
	I.transform = rotate
	I.flick_overlay(src, 3)

/obj/structure/machinery/defenses/sentry/proc/get_target(var/atom/movable/new_target)
	if(!targets.Find(new_target))
		targets.Add(new_target)

	if(!targets.len)
		return

	var/list/conscious_targets = list()
	var/list/unconscious_targets = list()

	for(var/atom/movable/A in targets) // orange allows sentry to fire through gas and darkness
		if(isliving(A))
			var/mob/living/M = A
			if(M.stat & DEAD)
				if(A == target)
					target = null
				targets.Remove(A)
				continue

			if(ishuman(A))
				var/mob/living/carbon/human/H = A
				if((H.faction in belonging_to_faction) || H.invisibility)
					if(A == target)
						target = null
					targets.Remove(H)
					continue

		else if(!(A.type in other_targets))
			if(A == target)
				target = null
			targets.Remove(A)
			continue

		var/opp
		var/adj
		switch(dir)
			if(NORTH)
				opp = x-A.x
				adj = A.y-y
			if(SOUTH)
				opp = x-A.x
				adj = y-A.y
			if(EAST)
				opp = y-A.y
				adj = A.x-x
			if(WEST)
				opp = y-A.y
				adj = x-A.x

		var/r = 9999
		if(adj != 0) 
			r = abs(opp/adj)
		var/angledegree = arcsin(r/sqrt(1+(r*r)))
		if(adj < 0 || (angledegree*2) > SENTRY_FIREANGLE)
			if(A == target)
				target = null
			targets.Remove(A)
			continue

		var/list/turf/path = getline2(src, A, include_from_atom = FALSE)
		if(!path.len || get_dist(src, A) > SENTRY_RANGE)
			if(A == target)
				target = null
			targets.Remove(A)
			continue

		var/blocked = FALSE
		for(var/turf/T in path)
			if(T.density || T.opacity)
				blocked = TRUE
				break

			for(var/obj/structure/S in T)
				if(S.opacity)
					blocked = TRUE
					break

			for(var/obj/effect/particle_effect/smoke/S in T)
				blocked = TRUE
				break

		if(blocked)
			if(A == target)
				target = null
			targets.Remove(A)
			continue

		if(isliving(A))
			var/mob/living/M = A
			if(M.stat & UNCONSCIOUS)
				unconscious_targets += M
			else
				conscious_targets += M

	if(conscious_targets.len)
		target = pick(conscious_targets)
	else if(unconscious_targets.len)
		target = pick(unconscious_targets)

	if(!target) //No targets, don't bother firing
		return

	fire(target.loc)

/obj/structure/machinery/defenses/sentry/Dispose() //Clear these for safety's sake.
	if(camera)
		qdel(camera)
		camera = null

	target = null
	delete_turret_triggers()
	SetLuminosity(0)
	. = ..()


/obj/structure/machinery/defenses/sentry/premade
	name = "UA-577 Gauss Turret"
	immobile = TRUE
	turned_on = TRUE
	icon_state = "sentry_on"

/obj/structure/machinery/defenses/sentry/premade/search_generators()
	return

/obj/structure/machinery/defenses/sentry/premade/power_on()
	return

/obj/structure/machinery/defenses/sentry/premade/power_off()
	return

obj/structure/machinery/defenses/sentry/premade/damaged_action()
	return

/obj/structure/machinery/defenses/sentry/premade/dumb
	name = "Modified UA-577 Gauss Turret"
	desc = "A deployable, semi-automated turret with AI targeting capabilities. Armed with an M30 Autocannon and a high-capacity drum magazine. This one's IFF system has been disabled, and it will open fire on any targets within range."
	belonging_to_faction = list("")
	ammo = new /obj/item/ammo_magazine/sentry/premade/dumb

//the turret inside a static sentry deployment system
/obj/structure/machinery/defenses/sentry/premade/deployable
	name = "UA-633 Static Gauss Turret"
	desc = "An fully-automated defence turret with mid-range targeting capabilities. Armed with a modified M32-S Autocannon and an internal belt feed."
	density = TRUE
	belonging_to_faction = list(FACTION_MARINE)
	fire_delay = 1
	ammo = new /obj/item/ammo_magazine/sentry/premade
	var/obj/structure/machinery/sentry_holder/deployment_system

/obj/structure/machinery/defenses/sentry/premade/deployable/Dispose()
	if(deployment_system)
		deployment_system.deployed_turret = null
		deployment_system = null
	. = ..()

/obj/structure/machinery/defenses/sentry/premade/deployable/colony
	belonging_to_faction = list(FACTION_MARINE, FACTION_COLONIST)

//the turret inside the shuttle sentry deployment system
/obj/structure/machinery/defenses/sentry/premade/dropship
	density = TRUE
	var/obj/structure/dropship_equipment/sentry_holder/deployment_system

/obj/structure/machinery/defenses/sentry/premade/dropship/Dispose()
	if(deployment_system)
		deployment_system.deployed_turret = null
		deployment_system = null
	. = ..()


/obj/effect/turret_trigger
	name = "turret trigger"
	icon = 'icons/effects/effects.dmi'
	anchored = TRUE
	mouse_opacity = 0
	invisibility = INVISIBILITY_MAXIMUM
	var/obj/structure/machinery/defenses/sentry/linked_turret

/obj/effect/turret_trigger/New(loc, var/obj/structure/machinery/defenses/sentry/source_turret)
	..()
	linked_turret = source_turret

/obj/effect/turret_trigger/Crossed(atom/movable/A)
	if(!linked_turret)
		qdel(src)
	linked_turret.get_target(A)


#undef SENTRY_FIREANGLE
#undef SENTRY_RANGE
#undef SENTRY_MUZZLELUM