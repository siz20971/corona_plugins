require ( "plugins.function_extends" )

local csvTools = {}

local function parseCSVSingleLine(line, keys)
	local newItem = {}
	local values = stringHelper.split(line, ",")

	-- TODO : "," 형식 처리

	if #values ~= #keys then
		print ("TODO : HANDLE EXCEPTION. Values " .. #values .. " Keys " .. #keys)
		return
	end

	for i = 1, #values, 1 do
		local key = keys[i]
		local strVal = values[i]
		local numVal = tonumber(strVal)

		if strVal == "true" or strVal == "TRUE" then
			newItem[key] = true
		elseif strVal == "false" or strVal == "FALSE" then
			newItem[key] = not true
		elseif numVal == nil then
			newItem[key] = strVal
		else
			newItem[key] = numVal
		end

		-- REMOVE ME
		-- print ("Type : " .. type(newItem[key]) .. "  Value : " .. tostring(newItem[key]))
	end

	return newItem
end

local function parseCSVLines(inputStr)
	-- TODO : Parsing 시작할 라인 지정.

	local result = {}

	local lines = stringHelper.split(inputStr, "\r\n")

	if #lines < 2 then
		print ("TODO : HANDLE EXCEPTION")
		return
	end

	local titles = stringHelper.split(lines[1], ",")
	for i = 2, #lines, 1 do
		local newItem = parseCSVSingleLine(lines[i], titles)
		result[i - 1] = newItem
	end

	return result
end

function csvTools:parseCSV(inputStr)
	return parseCSVLines(inputStr)
end

function csvTools:parseCSV2Dictionary(inputStr, keyColumnName, overwriteIfSameKey)
	-- TODO 
end

function csvTools:parseCSVFile(filePath)
    if filePath == nil then
    	print ("filePath nil")
    	return
    end

    local file = io.open(filePath, "rb")
	
	if file == nil then
		print ("TODO : HANDLE FILE NOT FOUND EXCEPTION. filePath : ".. filePath)
		return nil
	end

	local bodyText = file:read "*all"
	file:close()
	return csvTools:parseCSV(bodyText)
end

-- TODO : DemoScene 한쪽으로 이동. 
function csvTools:Debug()
	local debugString = "key,ko,en\nTEXT_01,텍스트,text\nTEXT_02,한글,English"
	local result = csvTools:parseCSV(debugString)

	print (result[2].en)

	local result2 = csvTools:parseCSVFile("../Demo/Resources/csvDemo.csv")

	if result2 ~= nil then
		print (result2[1].koKR)
	end
end

return csvTools