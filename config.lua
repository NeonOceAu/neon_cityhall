Config = {}

-- Check for updates.
Config.Version = true

-- Coordinates for the ped location
Config.PedLocation = vector4(-262.6533, -964.3658, 30.2237, 208.2225)

-- Ped model customization
Config.PedModel = "a_m_m_hasjew_01"

-- Blip settings
Config.EnableBlip = true
Config.Blip = {
    Sprite = 351,
    Color = 2,
    Scale = 1.0,
    Name = "City Hall"
}

-- Interaction configuration: Options 'ox_target', 'qb-target', 'textui'
Config.Interaction = 'ox_target'

-- Menu icons
Config.MenuIcons = {
    Jobs = "fa-solid fa-briefcase",
    Licenses = "fa-solid fa-id-card",
    Laws = "fa-solid fa-gavel"
}

-- Available Jobs configuration
Config.AvailableJobs = {
    { job = "garbage", label = "Garbage Collector", icon = "fa-solid fa-trash" },
    { job = "taxi", label = "Taxi Driver", icon = "fa-solid fa-taxi" },
    { job = "mechanic", label = "Mechanic", icon = "fa-solid fa-wrench" }
}

-- License Management configuration with prices for each license
Config.LicenseManagement = {
    { license = "driver", label = "Driver's License", price = 500 },
    { license = "weapon", label = "Weapon License", price = 1000 }
}

-- City Laws configuration with nested submenus
Config.CityLaws = {
    {
        title = "Traffic Laws",
        laws = {
            { title = "Speeding", description = "Do not exceed speed limits." },
            { title = "Running Red Lights", description = "Stop at all red lights." }
        }
    },
    {
        title = "Public Safety Laws",
        laws = {
            { title = "No Weapons in Public", description = "Keep weapons holstered in public spaces." },
            { title = "Respect Police Authority", description = "Follow all lawful orders given by police officers." }
        }
    },
    {
        title = "Environmental Laws",
        laws = {
            { title = "No Littering", description = "Dispose of waste in designated bins only." },
            { title = "Noise Pollution", description = "Keep noise levels reasonable in residential areas." }
        }
    }
}
