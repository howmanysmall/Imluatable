local DataStructures = require(script.Parent.DataStructures)
local Set = require(script.Parent.Set)
local t = require(script.Parent.Types)

local List = {
	ClassName = "List",
	__tostring = function()
		return "List"
	end,
}

local constructorType = t.optional(t.union(t.array(t.any), t.SetDataStructure))
local positiveInteger = t.intersection(t.numberPositive, t.integer)

function List.new(values)
	assert(constructorType(values), "")

	local self = {
		values = {},
		_dataStructure = DataStructures.ListDataStructure,
	}

	if values then
		if t.SetDataStructure(values) then
			for index, value in values:iterate() do
				self.values[index] = value
			end
		else
			for index, value in ipairs(values) do
				self.values[index] = value
			end
		end
	end

	return setmetatable(self, List)
end

function List.of(...)
	return List.new({...})
end

function List.isList(maybeList)
	return (t.ListDataStructure(maybeList))
end

function List:__index(key)
	if key == "size" then
		return #self.values
	elseif self[key] then
		return self[key]
	elseif List[key] then
		return List[key]
	else
		error(string.format("bad index %q in List", tostring(key)), 2)
	end
end

function List:set(index, value)
	assert(positiveInteger(index), "")

	local newValues = {}

	for valuesIndex, valuesValue in ipairs(self.values) do
	end

	self.values = newValues
	return self
end

return List