_G.MPGA = _G.MPGA or {}
MPGA.options_menu = "mpga_menu"
MPGA.ModPath = ModPath
MPGA.SaveFile = MPGA.SaveFile or SavePath .. "mpga.txt"
MPGA.ModOptions = MPGA.ModPath .. "menus/modoptions.txt"
MPGA.settings = MPGA.settings or {}
MPGA.stack_penalties = MPGA.stack_penalties or {}

MPGA.stack_penalties = {
  ["light"] = 10,
  ["coke_light"] = 10,
  ["medium"] = 30,
  ["heavy"] = 40,
  ["very_heavy"] = 50,
  ["mega_heavy"] = 60,
  ["being"] = 40,
  ["slightly_very_heavy"] = 40
}

-- MPGA Settings default, load, save
function MPGA:Reset()
  self.settings = {
    delay = 1,
    bile = true,
    twitch = true,
    stack_enable = true,
    cook_enable = true,
    xp_enable = true,
    xp_amount = 500000,
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

-- Getter methods for MPGA
function MPGA:CookEnabled()
  return self.settings.cook_enable
end

function MPGA:StackEnabled()
  return self.settings.stack_enable
end

function MPGA:XpEnabled()
  return self.settings.xp_enable
end

function MPGA:XpAmount()
  return self.settings.xp_amount
end

function MPGA:GetWeightForType(carry_id)
  local carry_type = tweak_data.carry[carry_id].type
  return self.stack_penalties[carry_type] ~= nil and ((100 - self.stack_penalties[carry_type]) / 100) or 1
end


-- Menu configuration
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
    ["mpga_menu_xp_enable_title"] = "XP Boost",
    ["mpga_menu_xp_enable_desc"] = "Only boost base XP if enabled.",
    ["mpga_menu_xp_amount_title"] = "XP Objective Amount",
    ["mpga_menu_xp_amount_desc"] = "Objective completion XP Boost.",
    ["mpga_menu_cook_enable_title"] = "Cook Helper",
    ["mpga_menu_cook_enable_desc"] = "Enable cook helper waypoints.",
    ["mpga_menu_stack_enable_title"] = "Stack Bags",
    ["mpga_menu_stack_enable_desc"] = "Enable bag stacking. Movement penalty applies.",
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
    desc = "mpga_menu_delay_desc",
    callback = "mpga_menu_delay_callback",
    value = MPGA.settings.delay,
    min = 1,
    max = 45,
    step = 1,
    show_value = true,
    menu_id = MPGA.options_menu,
    priority = 13,
  })

  MenuCallbackHandler.mpga_menu_cook_enable_callback = function(self, item)
    MPGA.settings.cook_enable = item:value() == "on" and true or false
    MPGA:Save()
  end
  MenuHelper:AddToggle({
    id = "mpga_menu_cook_enable_callback",
    title = "mpga_menu_cook_enable_title",
    desc = "mpga_menu_cook_enable_desc",
    callback = "mpga_menu_cook_enable_callback",
    value = MPGA.settings.cook_enable,
    menu_id = MPGA.options_menu,
    priority = 6,
  })

  MenuCallbackHandler.mpga_menu_stack_enable_callback = function(self, item)
    MPGA.settings.stack_enable = item:value() == "on" and true or false
    MPGA:Save()
  end
  MenuHelper:AddToggle({
    id = "mpga_menu_stack_enable_callback",
    title = "mpga_menu_stack_enable_title",
    desc = "mpga_menu_stack_enable_desc",
    callback = "mpga_menu_stack_enable_callback",
    value = MPGA.settings.stack_enable,
    menu_id = MPGA.options_menu,
    priority = 6,
  })

  MenuHelper:AddDivider({
    id = "xp_divider",
    size = 16,
    menu_id = MPGA.options_menu,
    priority = 3,
  })

  MenuCallbackHandler.mpga_menu_xp_enable_callback = function(self, item)
    MPGA.settings.xp_enable = item:value() == "on" and true or false
    MPGA:Save()
  end
  MenuHelper:AddToggle({
    id = "mpga_menu_xp_enable_callback",
    title = "mpga_menu_xp_enable_title",
    desc = "mpga_menu_xp_enable_desc",
    callback = "mpga_menu_xp_enable_callback",
    value = MPGA.settings.xp_enable,
    menu_id = MPGA.options_menu,
    priority = 2,
  })

  MenuCallbackHandler.mpga_menu_xp_amount_callback = function(self, item)
    MPGA.settings.xp_amount = math.floor(item:value())
    MPGA:Save()
  end
  MenuHelper:AddSlider({
    id = "mpga_menu_xp_amount_callback",
    title = "mpga_menu_xp_amount_title",
    desc = "mpga_menu_xp_amount_desc",
    callback = "mpga_menu_xp_amount_callback",
    value = MPGA.settings.xp_amount,
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