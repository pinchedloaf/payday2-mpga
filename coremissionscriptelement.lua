core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

if not Global.game_settings then
  return
end

Hooks:PreHook(MissionScriptElement, "_calc_base_delay", "mpga_calc_base_delay", function(self)
  local MPGA = _G.MPGA or {}
  if not MPGA or not MPGA.settings then

  else
    if Global.game_settings.level_id == "rat" or Global.game_settings.level_id == "alex_1" or Global.game_settings.level_id == "ratdaylight" then
      if self._id == 102197 and MPGA.settings.bile then
        self._values.base_delay_rand = nil
        self._values.base_delay = 1
      end
    end
  end
end)

Hooks:PreHook(MissionScriptElement, "_calc_element_delay", "mpga_calc_element_delay", function(self, params)
  local MPGA = _G.MPGA or {}
  if not MPGA or not MPGA.settings then

  else
    if ((Global.game_settings.level_id == "rat" or Global.game_settings.level_id == "alex_1" or Global.game_settings.level_id == "ratdaylight") and self._id == 100724) or 
      (Global.game_settings.level_id == "mex_cooking" and self._editor_name == "counter_below3") or
      ((Global.game_settings.level_id == "mia_1" or Global.game_settings.level_id == "crojob2") and self._editor_name == "timer_to_next") then
      params.delay_rand = nil
      params.delay = MPGA.settings.delay
      return MPGA.settings.delay + 0.1
    end
  end
end)
if not Global.game_settings.level_id == "rat" or not Global.game_settings.level_id == "alex_1" or not Global.game_settings.level_id == "ratdaylight" then
  return
end

local MPGA = _G.MPGA or {}

if not MPGA or not MPGA.settings.twitch then
  return
end

local _BLOCK_EVENT_102316 = MissionScriptElement.on_executed
function MissionScriptElement:on_executed(...)
  local _id = tostring(self._id)
  if _id == "102316" then
  else
    _BLOCK_EVENT_102316(self, ...)
  end
end
