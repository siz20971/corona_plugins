local physics = require "physics"
local json = require "json"

local M = {}

local path = 0

local function loadMapData(path)
	-- TODO : replace to --> assert (io.open (path, "r"))
	local f = io.open (path, "r")

	if f == nil then
		return nil
	end

	local text = f:read ("*all")
	f:close()

	local raw = loadstring(text)
	local data = raw()
	return data
end

function M.newMap(path)
	local map = display.newGroup()
	local layers = {}

	local mapInfo = {
		width = 0,
		height = 0,
		tileWidth = 0,
		tileHeight = 0
	}
	
	local data = loadMapData(path)

	mapInfo.width = data.width
	mapInfo.height = data.height
	mapInfo.tileWidth = data.tilewidth
	mapInfo.tileHeight = data.tileheight

	-- TODO : create sheet.
	local options = {
		width = mapInfo.tileWidth,
		height = mapInfo.tileHeight,
		numFrames = 336,
		sheetContentWidth = 1680,
		sheetContentHeight = 980
	}

	-- TODO : image path replace.
	local sheet = graphics.newImageSheet("plugins/Demo/Resources/tiled/demo_sheet.png", options)

	-- TODO : refactoring.
	-- draw tile map.
	for i = 1, #data.layers do

		local layerName = data.layers[i].name
		local layerGroup = display.newGroup()

		layers[layerName] = layerGroup

		-- draw all tiles.
		for j = 1, #data.layers[i].data do

			local index = data.layers[i].data[j]
			if data.layers[i].data[j] > 0 then
				local x = j % mapInfo.width
				local y = math.floor(j / mapInfo.height)

				local tile = display.newImageRect (layerGroup, sheet, index, mapInfo.tileWidth, mapInfo.tileHeight)
				tile.x = x * mapInfo.tileWidth
				tile.y = y * mapInfo.tileHeight
			end
		end
	end

	function map:changeVisible(layerName, isVisible)
		if layers[layerName] == nil then
			return
		end
		layers[layerName].isVisible = isVisible
	end

	return map
end

return M