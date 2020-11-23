Hooks:PreHook(ExperienceManager, "mission_xp", "mpga_mission_xp", function(self)
  local MPGA = _G.MPGA or {}
  if MPGA and MPGA.settings and MPGA.settings.xp_toggle then
    self._global.mission_xp_current = Application:digest_value(MPGA.settings.xp, true)
  end
end)