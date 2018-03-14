local composer = require ("composer")

-- Temp.
-- TODO : 다른 곳으로 이동.
local csvTools = require ("plugins.csvTools.csvTools")
csvTools:Debug()
-- Temp.

display.setDefault( "isImageSheetSampledInsideFrame", true )
display.setDefault( "background", 1, 1, 1 )
display.setStatusBar (display.HiddenStatusBar)

composer.gotoScene ("plugins.Demo.Demo_menu") --{ time = 1000, effect = "fade", params = { }} )