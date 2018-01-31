local M = {}

local sheet = require ("Imgs.vpad_images")
local objectSheet = graphics.newImageSheet( "plugins/inputIntegrate/Imgs/vpad_images.png", sheet:getSheet())

local composer = require ("composer")
local uiGroup

local deadzone = 0.3
local leftGroupEnabled = false
local rightGroupEnabled = false

local analogBg;
local analogThumb;

local analogLState = {
	touchID = "",
	radius = 80
}

local directionPad;

-----------------------
-- Debug
local analogLDebugTxt
-----------------------

local function Init()
	uiGroup = display.newGroup()

	system.activate("multitouch")

	
	local options = 
	{
	    text = "Hello World",     
	    x = 0,
	    y = 0,
	    font = native.systemFont,   
	    align = "center"  -- Alignment parameter
	}
	analogLDebugTxt = display.newText( options )
	analogLDebugTxt.anchorY = 0
	analogLDebugTxt.anchorX = 0
	analogLDebugTxt:setFillColor(0, 0, 0)
end

-- (..) events
local function onTouch (event)
	if event.id == analogLState.touchID then
		local phase = event.phase
		local newPosition = {}
		local deltaX = event.x - analogBg.x
		local deltaY = event.y - analogBg.y

		local angle = -math.atan2 (deltaY, deltaX)
		local distance = math.sqrt( deltaX ^ 2 + deltaY ^ 2 )

		-- print (angle)

		analogLDebugTxt.text = "[ANALOG L] TouchID : " .. tostring(analogLState.touchID) .. " (" .. event.x .. " . " .. event.y

		newPosition.x = event.x
		newPosition.y = event.y

		if (distance > analogLState.radius) then
			analogThumb.x = analogBg.x + analogLState.radius * math.cos(angle)
			analogThumb.y = analogBg.y - analogLState.radius * math.sin(angle)
		else
			analogThumb.x = event.x
			analogThumb.y = event.y
		end

		if phase == "ended" then
			analogLState.touchID = nil
			analogLDebugTxt.text = "[ANALOG L] "
			analogThumb.isVisible = false
		end
	end
end

local function onUpdate (event)
	
end

local function onAnalogTouch (event)
	local phase = event.phase
	
	if phase == "began" then
		print (event.id)

		analogLState.touchID = event.id

		analogThumb.isVisible = true
		analogThumb.x = event.x
		analogThumb.y = event.y
	end
end
-- ('') events


-- (..) Draw UIs
local function DrawDirectionPad()
	print ("Draw Direction Pad")
end

local function DrawAnalogPad(x, y)

	analogBg = display.newImageRect (uiGroup, objectSheet, sheet:getFrameIndex("analog_bg"), 160, 160)
	analogThumb = display.newImageRect (uiGroup, objectSheet, sheet:getFrameIndex("analog_thumb"), 48, 48)

	analogBg.x = x
	analogBg.y = y

	analogThumb.x = x
	analogThumb.y = y

	analogBg.width = analogBg.width * 4
	analogBg.height = analogBg.height * 4

	analogLState.radius = analogBg.width * 0.5

	analogThumb.isVisible = false

	analogBg:addEventListener( "touch", onAnalogTouch )
end

-- ----------------


function M.addDirectionPad (param)

end

function M.addAnalogPad (param)

end

function M.addInput (param)

end

function M.start()
	Init()

	Runtime:addEventListener( "touch", onTouch )
	Runtime:addEventListener( "enterFrame", onUpdate )

	DrawDirectionPad()
	DrawAnalogPad(display.contentCenterX, display.contentCenterY)
end

function M.remove()
	Runtime:addEventListener ( "touch", onTouch )
	Runtime:removeEventListener( "enterFrame", onUpdate )
end

return M