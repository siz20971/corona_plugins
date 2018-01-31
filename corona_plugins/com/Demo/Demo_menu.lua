require ( "com.function_extends" )

local composer = require( "composer" )

local scene = composer.newScene()

local menus = {
	"Virtual Joystick",
	"Demo 02",
	"Demo 03",	
	"Demo 04",
	"Demo 05",
	"Demo 06",
	"Demo 07",
	"Demo 08",
	"Demo 09"
}

local function onTouch (event)
	local btnName = event.target.name

	if event.phase == "ended" then
		if btnName == "Virtual Joystick" then
			composer.gotoScene ("com.Demo.Demo_vInput")
		else
			composer.gotoScene ("com.Demo.Demo_template")
		end
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local width = display.contentWidth / 3
	local height = display.contentHeight / 3

	local group = display.newGroup( )

	for i = 1, #menus, 1 do
		local x = ((i - 1) % 3) * width
		local y = math.floor ((i - 1) / 3) * height

		local newBtn = display.newRect(sceneGroup, x, y, width, height )
		newBtn:setFillColor((i - 1) / #menus, (i - 1) / #menus, (i - 1) / #menus )
		newBtn.anchorX = 0
		newBtn.anchorY = 0
		newBtn.name = menus[i]

		newBtn:addEventListener( "touch", onTouch )

		local text = display.newText(sceneGroup, menus[i] , x + width * 0.5, y + height * 0.5, nil, 40)
	end
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
