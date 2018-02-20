-- 플러그인용 함수 확장

-- math extend ---------------------------------

math.clamp = function(input, min, max)
		if input < min then
			return min
		elseif input > max then
			return max
		else
			return input
		end
	end

-- vector ---------------------------------

vector = {}

vector.distance = function (x1, y1, x2, y2)
		return math.sqrt ( (x1 - y1) ^ 2 + (x2 - y2) ^ 2 )
	end

vector.getRadianAngle = function (x, y)
		return math.atan2 ( y, x )
	end

vector.getDegree  = function (x, y)
		return vector.getRadianAngle ( x, y )  * ( 180 / math.pi )
	end

-- stringHelper ---------------------------------

stringHelper = {}

stringHelper.split = function (inputStr, seperator)
		if seperator == nil then
            seperator = "%s"
	    end

	    local t={}
	    i=1

	    for str in string.gmatch(inputStr, "([^".. seperator .."]+)") do
	            t[i] = str
	            i = i + 1
	    end
	    return t
	end