Hooks:PreHook(ExperienceManager, "mission_xp", "mpga_mission_xp", function(self)
  if MPGA:XpEnabled() then
    local current_xp = self._global.mission_xp_current and Application:digest_value(self._global.mission_xp_current, false) or 0
    self._global.mission_xp_current = Application:digest_value(current_xp + MPGA:XpAmount(), true)
  end
end)