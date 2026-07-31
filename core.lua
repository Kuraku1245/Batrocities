local mod_path = "" .. SMODS.current_mod.path

-- Batrocity joker pool
SMODS.ObjectType({
	key = "Batrocities",
	default = "j_btct_MichaelWave",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

-- Shape joker pool
SMODS.ObjectType({
	key = "Shape",
	default = "j_btct_Skwob",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

-- Tier 3 voucher pool
SMODS.ObjectType({
	key = "T3V",
	default = "v_blank",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

--Load Items files
local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	print("[Batrocities] Loading items file " .. file)
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err) 
	end
	f()
end

--Load Localization file
local files = NFS.getDirectoryItems(mod_path .. "localization")
for _, file in ipairs(files) do
	print("[Batrocities] Loading localization file " .. file)
	local f, err = SMODS.load_file("localization/" .. file)
	if err then
		error(err) 
	end
	f()
end

--Load Functions file
local files = NFS.getDirectoryItems(mod_path .. "functions")
for _, file in ipairs(files) do
	print("[Batrocities] Loading functions file " .. file)
	local f, err = SMODS.load_file("functions/" .. file)
	if err then
		error(err) 
	end
	f()
end

--Load Libs file
local files = NFS.getDirectoryItems(mod_path .. "libs")
for _, file in ipairs(files) do
	print("[Batrocities] Loading libs file " .. file)
	local f, err = SMODS.load_file("libs/" .. file)
	if err then
		error(err) 
	end
	f()
end
