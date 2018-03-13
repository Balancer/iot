if wifi.sta.status() == wifi.STA_GOTIP then
	return
end

wifi.setmode(wifi.STATION)
wifi.sta.connect()

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function()
	wifi.eventmon.unregister(wifi.eventmon.STA_GOT_IP)
	print("IP="..wifi.sta.getip())
	if file.exists("mqtt-hbr-send.lua") then
		loadfile("mqtt-hbr-send.lua")("/ips/" .. cfg.host, wifi.sta.getip())
	end

    if file.exists("mqtt-eclipse-send.lua") then
        loadfile("mqtt-eclipse-send.lua")("/bal/esp/ips/" .. cfg.host, wifi.sta.getip())
    end

	-- At end because not reenerable

    if ide_loaded == nil then
    	if file.exists("ide-bal.lc") then
	    	dofile("ide-bal.lc")
	    elseif file.exists("ide-bal.lua") then
		    dofile("ide-bal.lua")
	    end
     end
end)


tmr_wifi_check = tmr.create()
tmr_wifi_check:alarm(5000, tmr.ALARM_SINGLE, function()
    if wifi.sta.status() ~= 5 then
        print("Enduser Wi-Fi setup")
        if led_pin then
             gpio.write(led_pin, gpio.LOW)
             led_pin = nil
        end
        dofile("wifi-setup.lua")
    end
	tmr_wifi_check:unregister()
	tmr_wifi_check = nil
end)
