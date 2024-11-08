local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    RequestModel(Config.PedModel)
    while not HasModelLoaded(Config.PedModel) do
        Wait(0)
    end

    local ped = CreatePed(4, Config.PedModel, Config.PedLocation.xyz, Config.PedLocation.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    if Config.EnableBlip then
        local blip = AddBlipForCoord(Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z)
        SetBlipSprite(blip, Config.Blip.Sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.Blip.Scale)
        SetBlipColour(blip, Config.Blip.Color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blip.Name)
        EndTextCommandSetBlipName(blip)
    end

    if Config.Interaction == 'ox_target' then
        exports.ox_target:addLocalEntity(ped, {
            {
                name = 'neon_cityhall:menu',
                label = Strings.Target.CityHallLabel,
                icon = Strings.Target.CityHallIcon,
                distance = 2.0,
                onSelect = function()
                    TriggerEvent('neon_cityhall:openMenu')
                end
            }
        })
    elseif Config.Interaction == 'qb-target' then
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    label = Strings.Target.CityHallLabel,
                    icon = Strings.Target.CityHallIcon,
                    action = function()
                        TriggerEvent('neon_cityhall:openMenu')
                    end
                }
            },
            distance = 2.0
        })
    elseif Config.Interaction == 'textui' then
        Citizen.CreateThread(function()
            while true do
                local playerCoords = GetEntityCoords(PlayerPedId())
                local pedCoords = GetEntityCoords(ped)
                local distance = #(playerCoords - pedCoords)

                if distance < 2.0 then
                    lib.showTextUI(Strings.TextUI.CityHallPrompt)
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent('neon_cityhall:openMenu')
                    end
                else
                    lib.hideTextUI()
                end
                Wait(500)
            end
        end)
    end
end)

RegisterNetEvent('neon_cityhall:openMenu', function()
    lib.registerContext({
        id = 'cityhall_menu',
        title = 'City Hall Services',
        options = {
            { title = 'Available Jobs', icon = Config.MenuIcons.Jobs, event = 'neon_cityhall:availableJobs' },
            { title = 'License Management', icon = Config.MenuIcons.Licenses, event = 'neon_cityhall:openLicenseManagement' },
            { title = 'City Laws', icon = Config.MenuIcons.Laws, event = 'neon_cityhall:openCityLawsMenu' }
        }
    })
    lib.showContext('cityhall_menu')
end)

RegisterNetEvent('neon_cityhall:availableJobs', function()
    local jobOptions = {}

    for _, job in ipairs(Config.AvailableJobs) do
        table.insert(jobOptions, {
            title = job.label,
            icon = job.icon or "fa-solid fa-briefcase",
            description = 'Select ' .. job.label,
            onSelect = function()
                TriggerServerEvent('neon_cityhall:assignJob', job.job, job.label)
            end
        })
    end

    lib.registerContext({
        id = 'available_jobs_menu',
        title = 'Available Jobs',
        menu = 'cityhall_menu',
        options = jobOptions
    })
    lib.showContext('available_jobs_menu')
end)

RegisterNetEvent('neon_cityhall:openLicenseManagement', function()
    lib.registerContext({
        id = 'license_management_menu',
        title = 'License Management',
        menu = 'cityhall_menu',
        options = {
            { title = 'Purchase License', event = 'neon_cityhall:purchaseLicense' },
            { title = 'View Licenses', event = 'neon_cityhall:getLicenses' }
        }
    })
    lib.showContext('license_management_menu')
end)

RegisterNetEvent('neon_cityhall:getLicenses', function()
    TriggerServerEvent('neon_cityhall:getLicenses')
end)

RegisterNetEvent('neon_cityhall:purchaseLicense', function()
    local licenseOptions = {}

    for _, license in ipairs(Config.LicenseManagement) do
        table.insert(licenseOptions, {
            title = license.label,
            description = "Cost: $" .. license.price,
            onSelect = function()
                TriggerServerEvent('neon_cityhall:buyLicense', license.license, license.label, license.price)
            end
        })
    end

    lib.registerContext({
        id = 'purchase_license_menu',
        title = 'Purchase License',
        menu = 'license_management_menu',
        options = licenseOptions
    })
    lib.showContext('purchase_license_menu')
end)

RegisterNetEvent('neon_cityhall:viewLicenses', function(licenses)
    local licenseOptions = {}

    if next(licenses) == nil then
        table.insert(licenseOptions, { title = "No licenses found" })
    else
        for _, license in pairs(licenses) do
            table.insert(licenseOptions, { title = license.label })
        end
    end

    lib.registerContext({
        id = 'view_licenses_menu',
        title = 'Your Licenses',
        menu = 'license_management_menu',
        options = licenseOptions
    })
    lib.showContext('view_licenses_menu')
end)

RegisterNetEvent('neon_cityhall:openCityLawsMenu', function()
    local lawCategories = {}

    for _, category in ipairs(Config.CityLaws) do
        table.insert(lawCategories, {
            title = category.title,
            description = "View laws under " .. category.title,
            event = 'neon_cityhall:viewLawCategory',
            args = category
        })
    end

    lib.registerContext({
        id = 'citylaws_menu',
        title = 'City Laws',
        menu = 'cityhall_menu',
        options = lawCategories
    })
    lib.showContext('citylaws_menu')
end)

RegisterNetEvent('neon_cityhall:viewLawCategory', function(category)
    local lawOptions = {}

    for _, law in ipairs(category.laws) do
        table.insert(lawOptions, {
            title = law.title,
            description = law.description
        })
    end

    lib.registerContext({
        id = 'law_category_menu',
        title = category.title,
        menu = 'citylaws_menu',
        options = lawOptions
    })
    lib.showContext('law_category_menu')
end)

RegisterNetEvent('neon_cityhall:notifyJobAssigned', function(jobLabel)
    lib.notify({ 
        title = "Job Assignment", 
        description = string.format(Strings.Notifications.JobAssigned, jobLabel), 
        type = 'success' 
    })
end)

RegisterNetEvent('neon_cityhall:notifyLicensePurchase', function(licenseLabel, price)
    lib.notify({ 
        title = "License Purchased", 
        description = string.format(Strings.Notifications.LicensePurchased, licenseLabel, price), 
        type = 'success' 
    })
end)

RegisterNetEvent('neon_cityhall:notifyInsufficientFunds', function(price)
    lib.notify({ 
        title = "Insufficient Funds", 
        description = string.format(Strings.Notifications.InsufficientFunds, price), 
        type = 'error' 
    })
end)

RegisterNetEvent('neon_cityhall:notifyJobAssignmentError', function()
    lib.notify({ 
        title = "Job Assignment Error", 
        description = Strings.Notifications.JobAssignmentError, 
        type = 'error' 
    })
end)