wifi.setmode(wifi.STATION)
local station_cfg={}
station_cfg.ssid="foo"
station_cfg.pwd=""
station_cfg.auto=false
wifi.sta.config(station_cfg)
