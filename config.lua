Config = {}

Config.Showzone = false

Config.MicrophoneZones = {
    [1] = {
        name = "vinewood_bowl", 
        coords = vector3(683.37, 569.31, 130.46),
        size = vector3(3.4, 3.6, 2),
        spawnProp = true, -- if set to true, it will let you spawn the prop at location
        data = {
            debugPoly = Config.Showzone,
            heading = 340,
            data = {
                range = 50.0 -- range for the voice
            }
        }
    }
}
