local topic, message=...

if topic == nil then
     return
end

local mh = mqtt.Client(wifi.sta.getmac(), 120)
local sent = 0

mh:connect("iot.eclipse.org", 1883, 0,
    function(client)
        client:publish(topic, message, 0, 1)
        print("mqtt ok: iot.eclipse.org\n")
        sent = 1
    end,

    function(client, reason)
        print("MQTT send iot.eclipse.org error: " .. reason)
        sent = 1
    end)

mh:close();
