local count = 0

led_pin = 4 -- D1-mini; NodeMCU Dev board
gpio.mode(led_pin, gpio.OUTPUT)
gpio.write(led_pin, gpio.LOW)

if file.open("fail-counter.txt") then
	count = file.read()
    if count == nil then
          count = 0
    end
    count = tonumber(count)
	file.close()
end

if count >= 2 then
	print("Emergency stop")
	file.remove("fail-counter.txt")
	return
end

print("Fail proof check: ", count)

file.remove("fail-counter.txt")
file.open("fail-counter.txt","w+")
file.writeline(count+1)
file.close();

if not tmr.create():alarm(5000, tmr.ALARM_SINGLE, function()
		file.remove("fail-counter.txt")
		print("Fail proof check passed")
          if led_pin then
             gpio.write(led_pin, gpio.HIGH)
             led_pin = nil
          end
	end)
then
	print("Can't start timer")
     return
end

dofile('main.lua')
