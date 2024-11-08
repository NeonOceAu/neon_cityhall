local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('neon_cityhall:assignJob', function(jobName, jobLabel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and jobName then
        Player.Functions.SetJob(jobName, 0)
        TriggerClientEvent('neon_cityhall:notifyJobAssigned', src, jobLabel)
        LogJobAssignment(jobLabel, src)
    else
        TriggerClientEvent('neon_cityhall:notifyJobAssignmentError', src)
    end
end)

RegisterNetEvent('neon_cityhall:buyLicense', function(licenseType, licenseLabel, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and licenseType and price then
        local bankBalance = Player.Functions.GetMoney("bank")
        if bankBalance >= price then
            Player.Functions.RemoveMoney("bank", price)
            Player.PlayerData.metadata['licenses'] = Player.PlayerData.metadata['licenses'] or {}
            Player.PlayerData.metadata['licenses'][licenseType] = true
            Player.Functions.SetMetaData("licenses", Player.PlayerData.metadata["licenses"])

            TriggerClientEvent('neon_cityhall:notifyLicensePurchase', src, licenseLabel, price)
            LogLicensePurchase(licenseLabel, price, src)
        else
            TriggerClientEvent('neon_cityhall:notifyInsufficientFunds', src, price)
        end
    else
        print("Attempted exploit on license purchase event")
    end
end)

RegisterNetEvent('neon_cityhall:getLicenses', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local licenses = {}

    if Player then
        local playerLicenses = Player.PlayerData.metadata["licenses"] or {}

        for _, license in ipairs(Config.LicenseManagement) do
            if playerLicenses[license.license] then
                table.insert(licenses, license)
            end
        end

        TriggerClientEvent('neon_cityhall:viewLicenses', src, licenses)
    else
        print("Attempted exploit on getLicenses event")
    end
end)