-- client.lua

local lastHealth = 100

-- Function to apply the effect and make it fade out
local function applyShotEffect()
    local playerPed = PlayerPedId()

    -- Apply the ULP_PlayerWakeUp effect immediately
    StartScreenEffect("MenuMGSelectionIn", 0, false)

    -- Wait for 0.2 seconds to give the effect time to show
    Citizen.Wait(200)

    -- Fade-out over 0.5 seconds (change timing for smoothness)
    for i = 0, 100, 10 do
        -- Gradually reduce the intensity of the effect
        SetTimecycleModifierStrength(1 - (i / 100)) 
        Citizen.Wait(50)
    end
    
    -- Finally, stop the effect once it's faded out
    StopScreenEffect("MenuMGSelectionIn")
end

-- Listen for damage events
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local playerPed = PlayerPedId()
        local currentHealth = GetEntityHealth(playerPed)

        -- Only apply effect when health decreases (damage is taken)
        if currentHealth < lastHealth then
            applyShotEffect()
        end

        -- Update last health to current for next check
        lastHealth = currentHealth
    end
end)
