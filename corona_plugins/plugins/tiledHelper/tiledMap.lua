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

local function prepareTileSets(data)
	if data == nil or data.tilesets == nil or #data.tilesets == 0 then
		return nil
	end

	local retData = {}

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
		local imgPath = "plugins/Demo/Resources/tiled/map_sheet.png"

		if i == 2 then
			imgPath = "plugins/Demo/Resources/tiled/characters.png"
		end

		tileset.sheet = graphics.newImageSheet(imgPath, options)

		retData[i] = tileset
	end

	-- 
	function retData.getSheet (index)
		
	end

	return retData
end

function M.newMap(path, scale)
	local map = display.newGroup()
	local layers = {}
	local mapInfo = {}
	
	local data = readMapData(path)
	local tileSets = prepareTileSets(data)

	local function drawTile(group, index, coordX, coordY)
		local tileset = nil
		local realIndex
		local tile

		for i = 1, #tileSets do
			local lastIdx = tileSets[i].firstgid + tileSets[i].tilecount
			realIndex = index - tileSets[i].firstgid + 1 

			if index <= lastIdx then
				tileset = tileSets[i]
				break
			end
		end

		if tileset ~= nil and realIndex > 0 then
			tile = display.newImageRect (group, tileset.sheet, realIndex, tileset.tilewidth, tileset.tileheight)
			tile.x = coordX * mapInfo.tileWidth
			tile.y = coordY * mapInfo.tileHeight

			return tile
		end

		return nil
	end

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
			local layer = data.layers[i]
			local index = layer.data[j]

			drawTile (layerGroup, index, (j - 1) % mapInfo.width, math.floor((j-1) / mapInfo.height))

			--[[
			if index > 0 then
				local x = (j - 1) % mapInfo.width
				local y = math.floor((j-1) / mapInfo.height)
				local sheet, newIdx = imgSheets.getSheet(index)

				local tile = display.newImageRect (layerGroup, sheet, newIdx, mapInfo.tileWidth, mapInfo.tileHeight)
				tile.x = x * mapInfo.tileWidth
				tile.y = y * mapInfo.tileHeight
			end
			]]
		end
	end

	map.xScale = scale or 1
	map.yScale = scale or 1

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