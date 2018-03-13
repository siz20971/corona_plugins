require ( "plugins.function_extends" )

local composer = require( "composer" )

local scene = composer.newScene()
local map

local function onBackPressed (event)
	if event.phase == "ended" then
		composer.gotoScene ("plugins.Demo.Demo_menu")
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local tiled = require ("plugins.tiledHelper.tiledMap")

function onKeyEvent(event)
	local key = event.keyName
	local phase = event.phase

	if phase == "down" then
		if key == "z" then
			map:changeVisible("object", true)
		elseif key == "x" then
			map:changeVisible("object", false)
		end
	end
end

local function onLeftJoystick(event)
	map:translate(-event.x * 15, event.y * 15)
end

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local newBtn = display.newRect(sceneGroup, display.contentWidth, 0, display.contentWidth * 0.2, display.contentHeight * 0.13)
	newBtn:addEventListener( "touch", onBackPressed )
	newBtn:setFillColor(0.8, 0.8, 0.8)
	newBtn.anchorX = 1
	newBtn.anchorY = 0

	local text = display.newText( sceneGroup, "Back to menu", display.contentWidth, 30, nil, 30)
	text.anchorX = 1
	text.anchorY = 0

	-- Create Map.
	map = tiled.newMap("../Demo/Resources/tiled/map_demo.json")
	Runtime:addEventListener( "key", onKeyEvent)

	local vpad = require( "plugins.vInput.vpad")

	-- Add Analog Sticks.
	leftJoystick = vpad.addAnalogStick(display.contentWidth * 0.15, display.contentHeight * 0.75 , "leftJoystickEvent")
	Runtime:addEventListener( "leftJoystickEvent", onLeftJoystick )

	if map then
		self.view:insert(map)
	end
	self.view:insert(leftJoystick)
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
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene( composer.getSceneName( "previous" ) )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view	

	Runtime:removeEventListener( "key", onKeyEvent )
	Runtime:removeEventListener( "leftJoystickEvent", onLeftJoystick )
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
