local webhookUrl = 'REPLACE_WITH_YOUR_WEBHOOK' -- Replace with your actual Discord Webhook URL

function SendDiscordLog(title, fields)
    local embed = {
        {
            ["title"] = title,
            ["color"] = 16711680,
            ["fields"] = fields,
            ["footer"] = {
                ["text"] = "Logged at: " .. os.date("%Y-%m-%d %H:%M:%S")
            }
        }
    }

    PerformHttpRequest(webhookUrl, function(err, text, headers)
    end, 'POST', json.encode({username = "City Hall Logs", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function LogJobAssignment(jobName, player)
    local playerName = GetPlayerName(player)
    local fields = {
        {
            ["name"] = "Job Assigned",
            ["value"] = jobName,
            ["inline"] = true
        },
        {
            ["name"] = "Player",
            ["value"] = playerName,
            ["inline"] = true
        }
    }
    SendDiscordLog("Job Assignment", fields)
end

function LogLicensePurchase(licenseLabel, price, player)
    local playerName = GetPlayerName(player)
    local fields = {
        {
            ["name"] = "License Purchased",
            ["value"] = licenseLabel,
            ["inline"] = true
        },
        {
            ["name"] = "Cost",
            ["value"] = "$" .. tostring(price),
            ["inline"] = true
        },
        {
            ["name"] = "Player",
            ["value"] = playerName,
            ["inline"] = true
        }
    }
    SendDiscordLog("License Purchase", fields)
end