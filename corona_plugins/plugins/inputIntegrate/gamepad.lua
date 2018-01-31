local M = {}

local deadzone = 0.3

-- modulo
local function onAxisChanged (event)
	if math.abs(event.normalizedValue) < deadzone then
		return
	end

	-- XBOX
	--[[ 
	1 = left horizontal 
	2 = left vertical
	3 = right horizontal
	4 = right vertical
	5 = left trigger
	6 = right trigger
	]]
	print (" name : " .. event.axis.number .. " normalizedValue : " .. event.normalizedValue)
end

local function onKeyEvent (event)
	local keyName = event.keyName
	local phase = event.phase

	if event.device == nil then
		return
	end
	
	-- CHECK ME : 매번 체크가 필요할지 모르겠다.
	local isXInput = string.match(event.device.displayName, "XInput")

	if isXInput then
		
	else
		-- !! This condition contains PS4 dualshock. !!
		print ("NOT XInput")
	end

	print (event.device.displayName .. "KeyName : " .. keyName .. " Phase : " .. phase)
end

--[[
local function onInputDeviceStatusChanged (event)
	if event.connectionStateChanged then
		if event.device.isConnected then
			-- GameController connection found
		else
			-- GameController connection lost
		end
	end
end
]]--

local function onUpdate (event)
	
end

function M.start()
	Runtime:addEventListener( "axis", onAxisChanged)
	Runtime:addEventListener( "key", onKeyEvent)
	-- Runtime:addEventListener( "inputDeviceStatus", onInputDeviceStatusChanged)
	Runtime:addEventListener( "enterFrame", onUpdate)
end

function M.remove()
	Runtime:removeEventListener( "axis", onAxisChanged )
	Runtime:removeEventListener( "key", onKeyEvent )
	-- Runtime:removeEventListener( "inputDeviceStatus", onInputDeviceStatusChanged )
	Runtime:removeEventListener( "enterFrame", onUpdate )
end

return M