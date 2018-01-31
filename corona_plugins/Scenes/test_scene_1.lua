
local composer = require( "composer" )

local scene = composer.newScene()

local leftJoystick
local rightJoystick

local heroGroup
local hero
local line

math.clamp = function(input, min, max)
		if input < min then
			return min
		elseif input > max then
			return max
		else
			return input
		end
	end

local function prepareCharacter (self)
	heroGroup = display.newGroup( )

	hero = display.newCircle(heroGroup, 0, 0 , 15 )
	hero:setFillColor( 0, 0, 0 )

	line = display.newRect(heroGroup, hero.x, hero.y, display.contentWidth, 5 )
	line.anchorX = 0
	line.anchorY = 0.5
	line:setFillColor( 1, 0, 0 )
	line.alpha = 0.5
	line:toBack( )

	heroGroup.x = display.contentCenterX
	heroGroup.y = display.contentCenterY
end

local function updateCharacterMovement (x, y)
	local mul = 0.016 * 450

	local x = math.clamp(heroGroup.x + x * mul, 0, display.contentWidth)
	local y = math.clamp(heroGroup.y - y * mul, 0, display.contentHeight)

	heroGroup.x = x
	heroGroup.y = y
end

-- -----------------------------------------------------------------------------------
--  event functions
-- -----------------------------------------------------------------------------------
local function onLeftJoystick(event)
	updateCharacterMovement (event.x, event.y)
end

local function onRightJoystick(event)
	if event.phase == "began" then
		line.isVisible = true
	elseif event.phase == "ended" then
		line.isVisible = false
	else
		local angle = math.atan2 ( - event.y, event.x ) * (180/math.pi)
		line.rotation = angle
	end
end

local function onTouchButton (event)
	print (event.name .. event.buttonName .. event.phase)
end

local function prepareController ()
	require( "com.inputIntegrate.gamepad" ).start()

	local vpad = require( "com.inputIntegrate.vpad")

	-- Add Analog Sticks.
	leftJoystick = vpad.addAnalogStick(display.contentWidth * 0.15, display.contentHeight * 0.75 , "leftJoystickEvent")
	rightJoystick = vpad.addAnalogStick(display.contentWidth * 0.85, display.contentHeight * 0.75, "rightJoystickEvent")

	Runtime:addEventListener( "leftJoystickEvent", onLeftJoystick )
	Runtime:addEventListener( "rightJoystickEvent", onRightJoystick )

	-- Add Buttons.
	local btnOptions = {
		centerX = display.contentWidth * 0.75,
		centerY = display.contentHeight * 0.6,
		eventName = "onTouchButton",
		buttonName = "buttonA",
		imageName = "btn_A",
		width = 100,
		height = 100
	}

	vpad.addButton (btnOptions)

	btnOptions.centerX = btnOptions.centerX + 150
	btnOptions.centerY = btnOptions.centerY - 50
	btnOptions.buttonName = "buttonB"
	btnOptions.imageName = "btn_B"

	vpad.addButton (btnOptions)

	Runtime:addEventListener( "onTouchButton", onTouchButton )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	prepareCharacter()
	prepareController()
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		leftJoystick:destroy()
		rightJoystick:destroy()

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view	
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
