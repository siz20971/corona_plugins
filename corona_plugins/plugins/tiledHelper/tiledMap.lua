local physics = require "physics"
local json = require "json"

local M = {}

local function readMapData(path)
	local f = io.open (path, "r")

	if f == nil then
		return {}
	end

	local text = f:read ("*all")
	f:close()

	local data = json.decode(text)

	if data == nil then
		print ("ERR.JsonDecode Failed")
		return {}
	end

	-- TODO : tilesets 값이 맵에 embed 되지 않은 경우 추가 처리.

	return data
end

local function makeImageSheets(data)
	if data == nil or data.tilesets == nil or #data.tilesets == 0 then
		return nil
	end

	local imgSheets = {}

	for i = 1, #data.tilesets do
		local tileset = data.tilesets[i]

		local options = {
			width = tileset.tilewidth,
			height = tileset.tileheight,
			numFrames = tileset.tilecount,
			sheetContentWidth = tileset.imagewidth,
			sheetContentHeight = tileset.imageheight
		}

		-- TODO : image path replace.
		local sheet = graphics.newImageSheet("plugins/Demo/Resources/tiled/map_sheet.png", options)
		imgSheets[i] = sheet
	end
	
	return imgSheets
end

function M.newMap(path)
	local map = display.newGroup()
	local layers = {}
	local mapInfo = {}
	
	local data = readMapData(path)
	local imgSheets = makeImageSheets(data)

	mapInfo.width = data.width or 0
	mapInfo.height = data.height or 0
	mapInfo.tileWidth = data.tilewidth or 0
	mapInfo.tileHeight = data.tileheight or 0

	-- TODO : refactoring.
	-- draw tile map.
	for i = 1, #data.layers do

		local layerName = data.layers[i].name
		local layerGroup = display.newGroup()
		layers[layerName] = layerGroup
		map:insert(layerGroup)

		-- draw all tiles.
		for j = 1, #data.layers[i].data do
			local index = data.layers[i].data[j]
			if data.layers[i].data[j] > 0 then
				local x = (j - 1) % mapInfo.width
				local y = math.floor((j-1) / mapInfo.height)
				local sheet = imgSheets[1]

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

	function map:translate(dx, dy)
		local newX = map.x + dx
		local newY = map.y + dy

		map.x = newX
		map.y = newY
	end

	return map
end

return M