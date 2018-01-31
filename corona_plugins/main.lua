local composer = require ("composer")

display.setDefault( "background", 1, 1, 1 )
display.setStatusBar (display.HiddenStatusBar)

local menus = {
	"Virtual Joystick",
	"Empty",
	"Empty",	
	"Empty",
	"Empty",
	"Empty",
	"Empty",
	"Empty",
	"Empty"
}

--for i = #asteroidsTable, 1, -1 do

local function onTouch (event)
	local btnName = event.target.name

	if event.phase == "ended" then
		if btnName == "Virtual Joystick" then
			composer.gotoScene ("Scenes.test_scene_1", {time = 1000, effect = "fade", params = { }} )
		end
	end
end

local width = display.contentWidth / 3
local height = display.contentHeight * 0.3

for i = 1, #menus, 1 do
	local x = ((i - 1) % 3) * width
	local y = math.floor ((i - 1) / 3) * height

	local newBtn = display.newRect( x, y, width, height )
	newBtn:setFillColor( i / #menus, i / #menus, i / #menus )
	newBtn.anchorX = 0
	newBtn.anchorY = 0
	newBtn.name = menus[i]

	newBtn:addEventListener( "touch", onTouch )

	local text = display.newText( menus[i] , x + width * 0.5, y + height * 0.5, nil, 40)
end

--composer.gotoScene ("Scenes.test_scene_1", { param = {} } )