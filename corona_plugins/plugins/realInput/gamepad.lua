local converter = require("plugins.realInput.gamepadHelper")

local M = {}

local deviceInfo = { }
deviceInfo["type"] = ""

-- TODO Document
-- inputDeviceChanged - 입력 장치 변경 감지

-- TODO LIST
--[[
function 
	OnInputDeviceChanged
	SetDeadzone(float deadzone)
	SetLeftAnalogDeadzone (float deadzone)
	SetRightAnalogDeadzone (float deadzone)

	ChangeLeftTriggerMode(bool isButtonMode, float triggerValue (if nil 0.5. This value use when isButtonMode is true only.))
	ChangeRightTriggerMode(bool isButtonMode, float triggerValue (if nil 0.5. This value use when isButtonMode is true only.))
]]--

-- ButtonMapping
-- XBOX
--[[ 
buttonSelect
buttonStart
leftJoystickButton
rightJoystickButton
up
down
left
right
buttonA
buttonB
buttonX
buttonY
leftShoulderButton1
rightShoulderButton1

axis
1 = left horizontal 
2 = left vertical
3 = right horizontal
4 = right vertical
5 = left trigger
6 = right trigger
]]

local isAPressed = false
local ticktock = true

local inputs = {}

local function checkInputDeviceChange (event)
	local deviceType = ""

	if event.device ~= nil then
		deviceType = event.device.type
	end

	if deviceInfo.type ~= deviceType then
		print ("[ INPUT DEVICE CHANGED : " .. deviceInfo.type .. "->" .. deviceType .. "]")
		deviceInfo.type = deviceType

		local ev = {}
		ev.name = "inputDeviceChanged"
		Runtime:dispatchEvent( event )
	end
end

local function onAxisChanged (event)
	checkInputDeviceChange(event)
end

local function onKeyEvent (event)
	checkInputDeviceChange(event)

	if event.phase == "down" then
		isAPressed = true

		print (event.keyName .. " keyPressDown. " .. tostring(ticktock))

		event.ticktock = ticktock
		inputs[event.keyName] = event

	elseif event.phase == "up" then
		isAPressed = false

		print (event.keyName .. " keyPressUp. " .. tostring(ticktock))
	end
end

-- NOTE : Pressing event를 구현하려면 1프레임 대기 후 dispatch 해줘야 함.
-- 	onKeyEvent에서 버튼 입력 확인후 바로 onUpdate가 호출됨.
local function onUpdate ( event )

	for k, v in pairs(inputs) then
		
	end
	if isAPressed then
		print ("A Pressing . " .. tostring(ticktock))
		isAPressed = false
	end

	ticktock = not ticktock
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