-- 플러그인용 함수 확장

math.clamp = function(input, min, max)
		if input < min then
			return min
		elseif input > max then
			return max
		else
			return input
		end
	end