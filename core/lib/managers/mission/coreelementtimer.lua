core:module("CoreElementTimer")
core:import("CoreMissionScriptElement")
ElementTimer = ElementTimer or class(CoreMissionScriptElement.MissionScriptElement)

local MPGA = _G.MPGA or {}

if not MPGA or not MPGA.settings then
  return
end

if (not Global.game_settings or
    (Global.game_settings.level_id ~= "rat" and
     Global.game_settings.level_id ~= "alex_1" and
     Global.game_settings.level_id ~= "ratdaylight")) then
  return
end

Hooks:PostHook(ElementTimer, "timer_operation_reset", "mgpa_timer_operation_reset", function(self)
  if (not Global.game_settings or
      (Global.game_settings.level_id ~= "rat" and
       Global.game_settings.level_id ~= "alex_1" and
       Global.game_settings.level_id ~= "ratdaylight")) then
  else
    if (self._id == 102164 or self._id == 102166 or self._id == 102177 or self._id == 102178) and MPGA.settings.bile then
      self._timer = self:get_random_table_value_float(1)
      self:_update_digital_guis_timer()
    end
  end
end)
