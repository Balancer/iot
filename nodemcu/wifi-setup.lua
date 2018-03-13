-- wifi.setmode(wifi.STATIONAP)
-- wifi.ap.config({ssid=cfg.host, auth=wifi.OPEN})
-- enduser_setup.manual(true)

ide_loaded = 1

enduser_setup.start(
    function()
        print("Connected to wifi as:" .. (wifi.sta.getip() or "nil"))
        gpio.write(led_pin, gpio.HIGH)
        tmr.create():alarm(15000, tmr.ALARM_SINGLE, function()
            print("End user Wi-Fi setup")
            print("Normal restart")
            node.restart()
		end)
    end,
    function(err, str)
        print("enduser_setup: Err #" .. err .. ": " .. str)
    end,
    function(str)
        print("Debug:" .. str)
    end
);
