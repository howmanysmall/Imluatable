local DataStructures = require(script.Parent.DataStructures)
local t = require(script.Parent.t)

local Types = {}

local function isDataStructure(structure)
	assert(t.userdata(structure))
	return function(value)
		local tableSuccess, tableError = t.table(value)
		if not tableSuccess then
			return false, tableError or "bad type"
		end

		local dataStructure = value._dataStructure
		if not dataStructure then
			return false, "expected value to have a data structure, but didn't get one"
		end

		local userDataSuccess, userDataError = t.userdata(dataStructure)
		if not userDataSuccess then
			return false, userDataError or "bad type on data structure"
		end

		if dataStructure ~= structure then
			return false, string.format(
				"data structure %s expected, got %s instead",
				tostring(structure), tostring(dataStructure)
			)
		end

		return true
	end
end

Types.ListDataStructure = isDataStructure(DataStructures.ListDataStructure)
Types.SetDataStructure = isDataStructure(DataStructures.SetDataStructure)

return setmetatable(Types, {__index = t})