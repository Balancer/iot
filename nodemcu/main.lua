if file.exists("config.lua") then
    dofile("config.lua")
else
    cfg = { }
end

-- dofile("black-dual.lua")
-- dofile("example1.lua")

dofile('wifi-init.lua')

-- dofile("example2.lua")
