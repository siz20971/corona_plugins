require ( "plugins.function_extends" )

local composer = require( "composer" )

local scene = composer.newScene()

local function onBackPressed (event)
	if event.phase == "ended" then
		composer.gotoScene ("plugins.Demo.Demo_menu")
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	--[[ DELETE ME ]]
	local newBtn = display.newRect(sceneGroup, display.contentWidth, 0, display.contentWidth * 0.2, display.contentHeight * 0.13)
	newBtn:addEventListener( "touch", onBackPressed )
	newBtn:setFillColor(0.8, 0.8, 0.8)
	newBtn.anchorX = 1
	newBtn.anchorY = 0

	local text = display.newText( sceneGroup, "Back to menu", display.contentWidth, 30, nil, 30)
	text.anchorX = 1
	text.anchorY = 0
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
