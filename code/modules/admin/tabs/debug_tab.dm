/client/proc/enable_debug_verbs()
	set category = "Debug"
	set name = "*Debug Verbs - Show*"

	if(!check_rights(R_DEBUG)) 
		return

	verbs += debug_verbs
	verbs -= /client/proc/enable_debug_verbs

/client/proc/hide_debug_verbs()
	set category = "Debug"
	set name = "*Debug Verbs - Hide*"

	if(!check_rights(R_DEBUG)) 
		return

	verbs -= debug_verbs
	verbs += /client/proc/enable_debug_verbs

/client/proc/check_round_statistics()
	set category = "Debug"
	set name = "Round Statistics"
	if(!check_rights(R_ADMIN|R_DEBUG))	
		return

	debug_variables(round_statistics)

/client/proc/cmd_admin_delete(atom/O as obj|mob|turf in world)
	set category = "Debug"
	set name = "Delete"

	if (!admin_holder || !(admin_holder.rights & R_MOD))
		to_chat(src, "Only administrators may use this command.")
		return

	if (alert(src, "Are you sure you want to delete:\n[O]\nat ([O.x], [O.y], [O.z])?", "Confirmation", "Yes", "No") == "Yes")
		log_admin("[key_name(usr)] deleted [O] at ([O.x],[O.y],[O.z]) (<A HREF='?_src_=admin_holder;adminplayerobservejump=\ref[usr]'>JMP</A>)")
		message_admins("[key_name_admin(usr)] deleted [O] at ([O.x],[O.y],[O.z])")
		 
		qdel(O)

/client/proc/ticklag()
	set category = "Debug"
	set name = "Set Ticklag"
	set desc = "Sets a new tick lag. Recommend you don't mess with this too much! Stable, time-tested ticklag value is 0.9"

	if(!check_rights(R_DEBUG))	return
	if(!ishost(usr) || alert("Are you sure you want to do this?",, "Yes", "No") == "No") return
	var/newtick = input("Sets a new tick lag. Please don't mess with this too much! The stable, time-tested ticklag value is 0.9","Lag of Tick", world.tick_lag) as num|null
	//I've used ticks of 2 before to help with serious singulo lags
	if(newtick && newtick <= 2 && newtick > 0)
		log_admin("[key_name(src)] has modified world.tick_lag to [newtick]", 0)
		message_admins("[key_name(src)] has modified world.tick_lag to [newtick]")
		world.tick_lag = newtick
		 

		switch(alert("Enable Tick Compensation?","Tick Comp is currently: [config.Tickcomp]","Yes","No"))
			if("Yes")	config.Tickcomp = 1
			else		config.Tickcomp = 0
	else
		to_chat(src, SPAN_DANGER("Error: ticklag(): Invalid world.ticklag value. No changes made."))

/client/proc/fix_next_move()
	set category = "Debug"
	set name = "Unfreeze Everyone"
	if(alert("Are you sure you want to do this?",, "Yes", "No") == "No") return
	var/largest_move_time = 0
	var/largest_click_time = 0
	var/mob/largest_move_mob = null
	var/mob/largest_click_mob = null
	for(var/mob/M in mob_list)
		if(!M.client)
			continue
		if(M.next_move >= largest_move_time)
			largest_move_mob = M
			if(M.next_move > world.time)
				largest_move_time = M.next_move - world.time
			else
				largest_move_time = 1
		if(M.next_click >= largest_click_time)
			largest_click_mob = M
			if(M.next_click > world.time)
				largest_click_time = M.next_click - world.time
			else
				largest_click_time = 0
		log_admin("DEBUG: [key_name(M)]  next_move = [M.next_move]  next_click = [M.next_click]  world.time = [world.time]")
		M.next_move = 1
		M.next_click = 0
	message_admins("[key_name_admin(largest_move_mob)] had the largest move delay with [largest_move_time] frames / [largest_move_time/10] seconds!")
	message_admins("[key_name_admin(largest_click_mob)] had the largest click delay with [largest_click_time] frames / [largest_click_time/10] seconds!")
	message_admins("world.time = [world.time]")
	return

/client/proc/reload_admins()
	set name = "Reload Admins"
	set category = "Debug"
	if(alert("Are you sure you want to do this?",, "Yes", "No") == "No") return
	if(!check_rights(R_SERVER))	return

	message_admins("[usr.ckey] manually reloaded admins.")
	load_admins()

/client/proc/reload_whitelist()
	set name = "Reload Whitelist"
	set category = "Debug"
	if(alert("Are you sure you want to do this?",, "Yes", "No") == "No") return
	if(!check_rights(R_SERVER) || !RoleAuthority) return

	message_admins("[usr.ckey] manually reloaded the role whitelist.")
	RoleAuthority.load_whitelist()