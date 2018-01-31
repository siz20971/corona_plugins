local M = {}

local sheet = require ("com.inputIntegrate.Imgs.vpad_images")
local objectSheet = graphics.newImageSheet( "com/inputIntegrate/Imgs/vpad_images.png", sheet:getSheet())

local uiGroup

system.activate("multitouch")

local function addImageRect( group, imageName, centerX, centerY, width, height )
	local index = sheet:getFrameIndex(imageName)
	local frameInfo = sheet:getSheet().frames[index]

	local newWidth = width or frameInfo.width
	local newHeight = height or frameInfo.height

	local newImage = display.newImageRect(group, objectSheet, index, newWidth, newHeight)
	newImage.x = centerX or 0
	newImage.y = centerY or 0

	return newImage
end

-- TODO : Improve parameter to table
-- TODO : Add deadzone
function M.addAnalogStick(centerX, centerY, eventName)
	local instance = display.newGroup()

	local stickBg = addImageRect(instance, "analog_bg", centerX, centerY)
	local thumb = addImageRect(instance, "analog_thumb", centerX, centerY)
	local radius = stickBg.width * 0.5

	local evMap = 
	{
		name 	= eventName,
		phase   = "",				-- began moved pressed ended
		touched = false,
		touchID = nil,
		x 		= 0,
		y 		= 0,
		touchX 	= 0,
	    touchY 	= 0
	}

	local touchPos = {	x = 0,	y = 0	}

	--[[
	local is_debug_mode = true
	local options = 
	{
		parent = inatance,
	    text = "",
	    x = centerX,
	    y = centerY - radius,
	    fontSize = 40,
	    font = native.systemFont,
	    aline = "center"
	}
	local statusLabel = display.newText( options )
	statusLabel:setFillColor( 0, 0, 0 )
	]]--

	local function updateThumbPosition()
		thumb.isVisible = evMap.touched

		local deltaX = touchPos.x - stickBg.x
		local deltaY = touchPos.y - stickBg.y

		local angle 	= - math.atan2 ( deltaY, deltaX )
		local distance 	= 	math.sqrt (deltaX ^ 2 + deltaY ^ 2)

		local tmp = math.min( distance, radius ) / radius

		evMap.x = math.cos(angle) * tmp
		evMap.y = math.sin(angle) * tmp

		if (distance > radius) then
			thumb.x = stickBg.x + evMap.x * radius
			thumb.y = stickBg.y - evMap.y * radius
		else
			thumb.x = touchPos.x
			thumb.y = touchPos.y
		end

		--[[
		if is_debug_mode then
			if evMap.touched then
				statusLabel.text = string.format("%.2f , %.2f", evMap.x, evMap.y)
			else
				statusLabel.text = ""
			end
		end
		]]--
	end

	function stickBg:touch (event)
		local phase = event.phase
		if phase == "began" and evMap.touched == false then
			evMap.touched = true
			evMap.touchID = event.id
			evMap.phase = "began"

			touchPos.x = event.x
			touchPos.y = event.y

			updateThumbPosition()
		end
	end

	local function onUpdate ( event )
		if evMap.touched then
			Runtime:dispatchEvent(evMap)
			evMap.phase = "pressed"
		end
	end

	local function onTouch( event )

		if not evMap.touched then
			return
		end

		if event.id ~= evMap.touchID then
			return
		end

		touchPos.x = event.x
		touchPos.y = event.y

		if event.phase == "ended" then
			evMap.touched = false
			evMap.touchID = nil
			evMap.phase = "ended"

			Runtime:dispatchEvent(evMap)
			updateThumbPosition()
		elseif event.phase == "moved" then
			evMap.phase = "moved"
			updateThumbPosition()
		end
	end

	function instance:activate()
		self:addEventListener( "touch", stickBg )
		Runtime:addEventListener( "touch", onTouch )
		Runtime:addEventListener ( "enterFrame", onUpdate)
	end

	function instance:deactivate()
		self:removeEventListener( "touch", stickBg )
		Runtime:addEventListener( "touch", onTouch )
		Runtime:removeEventListener( "enterFrame", onUpdate )
	end

	function instance:destroy()
		instance:deactivate()

		display.remove( stickBg )
		display.remove( thumb )
	end

	instance:activate()
	updateThumbPosition()

	return instance
end



-- transition.to( target, params )

-- OPTION PARAMS
--[[
centerX
NUMBER. ~~

centerY

eventName

buttonName

imageName

width (optional)

height (optional)
]]
function M.addButton (options)
	local instance = display.newGroup()

	-- TODO : handle EXCEPTION 

	local button = addImageRect(
		instance, 
		options.imageName, 
		options.centerX, 	options.centerY, 
		options.width, 		options.height)

	local evMap = 
	{
		name 	= options.eventName,
		buttonName = options.buttonName,
		phase   = ""				-- began ended
	}

	function button:touch (event)
		local phase = event.phase
		evMap.phase = phase

		if phase == "began" then
			Runtime:dispatchEvent( evMap )
		elseif phase == "ended" then
			Runtime:dispatchEvent( evMap )
		end
	end

	function instance:activate()
		self:addEventListener( "touch", button )
	end

	function instance:deactivate()
		self:removeEventListener( "touch", button )
	end

	function instance:destroy()
		instance:deactivate()

		display.remove( button )
	end

	instance:activate()

	return instance
end

return M