local function giveCC(value)
	local current = Application:digest_value(managers.custom_safehouse._global.total)
	local future = current + value
	Global.custom_safehouse_manager.total = Application:digest_value(future, true)
end
giveCC(10)