local oldProximity = 0.0
local defaultProp = "v_ilev_fos_mic"
local zones = {}


local onEnter = function(self)
    oldProximity =  LocalPlayer.state['proximity'].distance
    exports["pma-voice"]:overrideProximityRange(self.data.range, true)
end

local onExit = function(self)
    exports["pma-voice"]:clearProximityOverride()
end
CreateThread(function()
    for k, v in pairs(Config.MicrophoneZones) do
        table.insert(zones, 
            lib.zones.box({
                coords = v.coords,
                size = v.size,
                range = v.range,
                onEnter = onEnter,
                onExit = onExit,
                debug = Config.Showzone
            })
        )
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
        inRange = false
        local pos = GetEntityCoords(cache.ped)
        for k,v in ipairs(Config.MicrophoneZones) do
            if v.spawnProp then
                local dist = #(pos - v.coords)
                if dist <= 150.0 then
                    if v.obj == nil then
                        local obj = CreateObject(GetHashKey(v.prop or defaultProp), vector3(v.coords.x, v.coords.y, v.coords.z - 1.0), false)
                        if v.data.heading ~= nil then
                            SetEntityHeading(obj, v.heading)
                        end
                        FreezeEntityPosition(obj, true)
                        v.obj = obj
                    end
                else
                    if v.obj then
                        DeleteEntity(v.obj)
                        v.obj = nil
                    end
                end
            end
        end

		if not inRange then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if (GetCurrentResourceName() ~= resource) then return end
    for k, v in pairs(Config.MicrophoneZones) do
        if v.obj then
            DeleteEntity(v.obj)
            v.obj = nil
        end
    end
end)