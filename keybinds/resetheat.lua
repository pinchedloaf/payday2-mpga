for id, val in pairs(managers.job._global.heat) do
  if managers.job._global.heat[id] < 0 then
    managers.job._global.heat[id] = 0
  end
end