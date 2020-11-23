_G.MPGA = _G.MPGA or {}
MPGA.options_menu = "mpga_menu"
MPGA.ModPath = ModPath
MPGA.SaveFile = MPGA.SaveFile or SavePath .. "mpga.txt"
MPGA.ModOptions = MPGA.ModPath .. "menus/modoptions.txt"
MPGA.settings = MPGA.settings or {}

function MPGA:Reset()
  self.settings = {
    delay = 1,
    bile = true,
    twitch = true,
    xp = 500000,
    xp_toggle = true,
  }
  self:Save()
end

function MPGA:Load()
  local file = io.open(self.SaveFile, "r")
  if file then
    for key, value in pairs(json.decode(file:read("*all"))) do
      self.settings[key] = value
    end
    file:close()
  else
    self:Reset()
  end
end

function MPGA:Save()
  local file = io.open(self.SaveFile, "w+")
  if file then
    file:write(json.encode(self.settings))
    file:close()
  end
end

MPGA:Load()

Hooks:Add("LocalizationManagerPostInit", "mpga_loc", function(loc)
  LocalizationManager:add_localized_strings({
    ["mpga_menu_title"] = "MPGA",
    ["mpga_menu_desc"] = "Make Payday Great Again",
    ["mpga_menu_delay_title"] = "Time for Callout",
    ["mpga_menu_delay_desc"] = "Non-randomized time between Bain callouts.",
    ["mpga_menu_bile_title"] = "Fast Bile",
    ["mpga_menu_bile_desc"] = "Bile immediately flies in on flare trigger.",
    ["mpga_menu_twitch_title"] = "Twitch Stay",
    ["mpga_menu_twitch_desc"] = "Twitch will stay after arriving.",
    ["mpga_menu_xp_toggle_title"] = "XP Boost",
    ["mpga_menu_xp_toggle_desc"] = "Only boost base XP if enabled.",
    ["mpga_menu_xp_title"] = "XP Contract Amount",
    ["mpga_menu_xp_desc"] = "Contract completion XP override.",
  })
end)

Hooks:Add("MenuManagerSetupCustomMenus", "MPGAOptions", function( menu_manager, nodes )
  MenuHelper:NewMenu( MPGA.options_menu )
end)

Hooks:Add("MenuManagerPopulateCustomMenus", "MPGAOptions", function( menu_manager, nodes )
  MenuCallbackHandler.mpga_menu_bile_callback = function(self, item)
    MPGA.settings.bile = item:value() == "on" and true or false
    MPGA:Save()
  end
  MenuHelper:AddToggle({
    id = "mpga_menu_bile_callback",
    title = "mpga_menu_bile_title",
    desc = "mpga_menu_bile_desc",
    callback = "mpga_menu_bile_callback",
    value = MPGA.settings.bile,
    menu_id = MPGA.options_menu,
    priority = 16,
  })

  MenuCallbackHandler.mpga_menu_twitch_callback = function(self, item)
    MPGA.settings.twitch = item:value() == "on" and true or false
    MPGA:Save()
  end
  MenuHelper:AddToggle({
    id = "mpga_menu_twitch_callback",
    title = "mpga_menu_twitch_title",
    desc = "mpga_menu_twitch_desc",
    callback = "mpga_menu_twitch_callback",
    value = MPGA.settings.twitch,
    menu_id = MPGA.options_menu,
    priority = 15,
  })

  MenuCallbackHandler.mpga_menu_delay_callback = function(self, item)
    MPGA.settings.delay = math.floor(item:value())
    MPGA:Save()
  end
  MenuHelper:AddSlider({
    id = "mpga_menu_delay_callback",
    title = "mpga_menu_delay_title",
    callback = "mpga_menu_delay_callback",
    value = MPGA.settings.delay,
    min = 1,
    max = 45,
    step = 1,
    show_value = true,
    menu_id = MPGA.options_menu,
    priority = 13,
  })

  MenuHelper:AddDivider({
    id = "xp_divider",
    size = 16,
    menu_id = MPGA.options_menu,
    priority = 3,
  })

  MenuCallbackHandler.mpga_menu_xp_toggle_callback = function(self, item)
    MPGA.settings.xp_toggle = item:value() == "on" and true or false
    MPGA:Save()
  end
  MenuHelper:AddToggle({
    id = "mpga_menu_xp_toggle_callback",
    title = "mpga_menu_xp_toggle_title",
    desc = "mpga_menu_xp_toggle_desc",
    callback = "mpga_menu_xp_toggle_callback",
    value = MPGA.settings.xp_toggle,
    menu_id = MPGA.options_menu,
    priority = 2,
  })

  MenuCallbackHandler.mpga_menu_xp_callback = function(self, item)
    MPGA.settings.xp = math.floor(item:value())
    MPGA:Save()
  end
  MenuHelper:AddSlider({
    id = "mpga_menu_xp_callback",
    title = "mpga_menu_xp_title",
    desc = "mpga_menu_xp_desc",
    callback = "mpga_menu_xp_callback",
    value = MPGA.settings.xp,
    min = 0,
    max = 500000,
    step = 1000,
    show_value = true,
    menu_id = MPGA.options_menu,
    priority = 1,
  })
end)

Hooks:Add("MenuManagerBuildCustomMenus", "MPGAOptions", function(menu_manager, nodes)
  nodes[MPGA.options_menu] = MenuHelper:BuildMenu( MPGA.options_menu )
  MenuHelper:AddMenuItem(nodes["blt_options"], MPGA.options_menu, "mpga_menu_title", "mpga_menu_desc")
end)
