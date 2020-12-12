
/datum/surgery/stitching
    name = "Simple Restoration"
    steps = list(/datum/surgery_step/apply_healing_paste,
                 /datum/surgery_step/retract_skin,
                 /datum/surgery_step/sew_flesh)
    lying_required = FALSE
    self_operable = TRUE
    pain_reduction_required = PAIN_REDUCTION_LIGHT

/datum/surgery/stitching/complete()
    if(affected_limb)
        if(affected_limb.integrity_level <= LIMB_INTEGRITY_OKAY)
            affected_limb.set_integrity_level(LIMB_INTEGRITY_PERFECT)
    return ..()
    
/datum/surgery_step/apply_healing_paste
    name = "Apply healing paste"
    time = 4 SECONDS
    tools = list(/obj/item/tool/surgery/cell_gel = 100, /obj/item/stack/medical/ointment = 40)

/datum/surgery_step/apply_healing_paste/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    user.visible_message(SPAN_NOTICE("[user] starts applying [tool] to [target]'s [parse_zone(target_zone)]."),
		SPAN_NOTICE("You start applying [tool] to [target]'s [parse_zone(target_zone)]..."))

/datum/surgery_step/apply_healing_paste/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.apply_damage(-5, BRUTE,target_zone)

/datum/surgery_step/apply_healing_paste/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.apply_damage(2, TOX, target_zone)

/datum/surgery_step/sew_flesh
    name = "Suture"
    time = 4 SECONDS    
    tools = list(/obj/item/tool/surgery/surgical_line = 100, /obj/item/stack/cable_coil = 10)

/datum/surgery_step/sew_flesh/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    user.visible_message(SPAN_NOTICE("[user] starts sewing [target]'s [parse_zone(target_zone)]'s skin shut with \the [tool]."),
		SPAN_NOTICE("You start sewing \the [parse_zone(target_zone)]'s skin shut with \the [tool]..."))

/datum/surgery_step/sew_flesh/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.apply_damage(-5, BRUTE,target_zone)

/datum/surgery_step/sew_flesh/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.apply_damage(2, BRUTE, target_zone)

/datum/surgery/superficial_restoration
    name = "Superficial Restoration"
    steps = list(/datum/surgery_step/move_bone,
                 /datum/surgery_step/incision,
                 /datum/surgery_step/retract_skin,
                 /datum/surgery_step/dig_shrapnel,
                 /datum/surgery_step/close_ruptured_veins,
                 /datum/surgery_step/drain_blood,
                 /datum/surgery_step/close_incision)
    lying_required = FALSE
    self_operable = TRUE
    pain_reduction_required = PAIN_REDUCTION_FULL

/datum/surgery/superficial_restoration/complete()
    if(affected_limb)
        if(affected_limb.integrity_level <= LIMB_INTEGRITY_CONCERNING)
            affected_limb.set_integrity_level(LIMB_INTEGRITY_PERFECT)
    return ..()

/datum/surgery_step/move_bone
    name = "Move dislocated bone"
    accept_hand = TRUE
    time = 2 SECONDS

/datum/surgery_step/move_bone/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
     user.visible_message(SPAN_NOTICE("[user] grabs [target]'s [parse_zone(target_zone)] and attempts to push its dislocated bones into place."),
		SPAN_NOTICE("You start pushing [target]'s [parse_zone(target_zone)]'s bones into place ..."))

/datum/surgery_step/move_bone/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.pain.apply_pain(-5, BRUTE)

/datum/surgery_step/move_bone/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.pain.apply_pain(10, BRUTE)

/datum/surgery_step/dig_shrapnel
    name = "Dig shrapnel"
    tools = list(/obj/item/tool/surgery/hemostat = 100, /obj/item/tool/surgery/scalpel = 60, /obj/item/attachable/bayonet = 40, /obj/item/tool/kitchen/knife = 20)
    time = 3 SECONDS

/datum/surgery_step/dig_shrapnel/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
     user.visible_message(SPAN_NOTICE("[user] start escavating shrapnel from inside [target]'s [parse_zone(target_zone)] with \the [tool]."),
		SPAN_NOTICE("You start picking shrapnel from [target]'s [parse_zone(target_zone)] with \the [tool] ..."))

/datum/surgery_step/dig_shrapnel/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.apply_damage(-5, BRUTE)

/datum/surgery_step/dig_shrapnel/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.apply_damage(10, BRUTE)

/datum/surgery_step/close_ruptured_veins
    name = "Close vein ruptures"
    tools = list(/obj/item/tool/surgery/cell_gel = 100, /obj/item/tool/surgery/cautery = 60, /obj/item/tool/lighter = 35)
    time = 4 SECONDS

/datum/surgery_step/close_ruptured_veins/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
     user.visible_message(SPAN_NOTICE("[user] tries to seal [target]'s [parse_zone(target_zone)] with \the [tool]."),
		SPAN_NOTICE("You start sealing \the [parse_zone(target_zone)]'s ruptured veins with \the [tool] ..."))

/datum/surgery_step/close_ruptured_veins/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    surgery.affected_limb.remove_all_bleeding()

/datum/surgery_step/close_ruptured_veins/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.apply_damage(5, BURN)

/datum/surgery_step/drain_blood
    name = "Drain blood pools"
    tools = list(/obj/item/tool/surgery/handheld_pump = 100, /obj/item/reagent_container/glass = 30)
    time = 3 SECONDS

/datum/surgery_step/drain_blood/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
     user.visible_message(SPAN_NOTICE("[user] starts draining blood pools from [target]'s [parse_zone(target_zone)] with \the [tool]."),
		SPAN_NOTICE("You start draining the blood pools inside \the [parse_zone(target_zone)] with \the [tool] ..."))

/datum/surgery_step/drain_blood/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.pain.apply_pain(-5, BRUTE)

/datum/surgery_step/drain_blood/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    if(istype(target))
        target.drip(10)

/datum/surgery/structural_rejuvenation
    name = "Structural Rejuvenation"
    steps = list(
        /datum/surgery_step/incision,
        /datum/surgery_step/clamp_bleeders,
        /datum/surgery_step/retract_skin,
        /datum/surgery_step/dig_shrapnel,
        /datum/surgery_step/drain_fracture,
        /datum/surgery_step/heal_bone,
        /datum/surgery_step/close_ruptured_veins,
        /datum/surgery_step/drain_blood,
        /datum/surgery_step/close_incision
    )

/datum/surgery/structural_rejuvenation/complete()
    if(affected_limb)
        if(affected_limb.integrity_level <= LIMB_INTEGRITY_SERIOUS)
            affected_limb.set_integrity_level(LIMB_INTEGRITY_PERFECT)
    return ..()

/datum/surgery_step/drain_fracture
    name = "Drain fracture"
    tools = list(/obj/item/tool/surgery/handheld_pump = 100, /obj/item/reagent_container/glass = 30)
    time = 4 SECONDS   

/datum/surgery_step/drain_fracture/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
     user.visible_message(SPAN_NOTICE("[user] starts draining liquids pooled inside the fracture on [target]'s [parse_zone(target_zone)] with \the [tool]."),
		SPAN_NOTICE("You start draining the liquid inside \the [parse_zone(target_zone)]'s fracture with \the [tool] ..."))

/datum/surgery_step/drain_fracture/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.apply_damage(5, TOX)

/datum/surgery_step/heal_bone
    name = "Heal bone tissue"
    tools = list(/obj/item/tool/surgery/cell_gel = 100, /obj/item/stack/medical/ointment = 30)
    time = 4 SECONDS   

/datum/surgery_step/heal_bone/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
     user.visible_message(SPAN_NOTICE("[user] starts applying \the [tool] to [target]'s [parse_zone(target_zone)]'s fracture."),
		SPAN_NOTICE("You start applying \the [tool] to \the [parse_zone(target_zone)]'s fracture ..."))

/datum/surgery_step/heal_bone/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
    . = ..()
    target.apply_damage(5, TOX)

/datum/surgery/close_stump
    name = "Seal limb stump"
    steps = list(
        /datum/surgery_step/clamp_bleeders,
        /datum/surgery_step/retract_skin,
        /datum/surgery_step/carve_amputation,
        /datum/surgery_step/close_ruptured_veins,
        /datum/surgery_step/close_amputation
    )
    requires_bodypart = FALSE

/datum/surgery/close_stump/can_start(mob/user, mob/living/carbon/patient)
    var/obj/limb/L = patient.get_limb(user.zone_selected)
    if(!L)
        return FALSE
    if(!L.get_damage())
        return FALSE
    return ..()
    