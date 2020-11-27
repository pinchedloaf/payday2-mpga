function add_waypoint(id, pos, col)
  col = col or Color.white
  managers.hud:add_waypoint(id, {icon = "wp_standard", position = pos, distance = false, present_timer = 0, no_sync = true, color = col})
end

function remove_waypoint(id)
  managers.hud:remove_waypoint(id)
end

local cook_unit = cook_unit or nil
local old_remove = old_remove or ObjectInteractionManager.remove_unit

function ObjectInteractionManager:remove_unit(unit)
  if cook_unit and cook_unit == unit then
    remove_waypoint(tostring(unit:name()))
    cook_unit = nil
  end
  old_remove(self, unit)
end

Hooks:PreHook(DialogManager, "queue_dialog", "mpga_dialogmanager_queue_dialog", function(self, id, params)
  if MPGA:CookEnabled() then
    local tweak_id = ((id == "pln_rt1_20" or id == "pln_rat_stage1_20" or id == "Play_loc_mex_cook_03") and "methlab_bubbling")
            or ((id == "pln_rt1_22" or id == "pln_rat_stage1_22" or id == "Play_loc_mex_cook_04") and "methlab_caustic_cooler")
            or ((id == "pln_rt1_24" or id == "pln_rat_stage1_24" or id == "Play_loc_mex_cook_05") and "methlab_gas_to_salt")
            or nil

    if tweak_id then
      for _,unit in pairs(managers.interaction._interactive_units) do
        if unit and unit:interaction() and unit:interaction().tweak_data == tweak_id then
          add_waypoint(tostring(unit:name()), unit:position(), Color.white)
          cook_unit = unit
        end
      end
    end
  end
end)