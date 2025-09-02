local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local isLeoActive = false

local function isLeoJob(job)
    if not job then return false end
    if Config.ConsiderJobTypeLeo and job.type and job.type:lower() == 'leo' then
        return true
    end
    if job.name and Config.LeoJobs[job.name] then
        return true
    end
    return false
end

local function shouldBuff()
    if not PlayerData or not PlayerData.job then return false end
    if not isLeoJob(PlayerData.job) then return false end
    if Config.OnlyOnDuty and not PlayerData.job.onduty then return false end
    return true
end

local function refreshState()
    isLeoActive = shouldBuff()
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    refreshState()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    if not PlayerData then PlayerData = {} end
    PlayerData.job = job
    refreshState()
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    if PlayerData and PlayerData.job then
        PlayerData.job.onduty = duty
        refreshState()
    end
end)

CreateThread(function()
    while not LocalPlayer.state.isLoggedIn do
        Wait(500)
    end
    PlayerData = QBCore.Functions.GetPlayerData()
    refreshState()
end)

CreateThread(function()
    while true do
        if isLeoActive then
            local ped = PlayerPedId()
            if IsPedRunning(ped) or IsPedSprinting(ped) then
                RestorePlayerStamina(PlayerId(), Config.BonusRestorePerTick or 0.15)
                Wait(Config.BonusRestoreInterval or 250)
            else
                RestorePlayerStamina(PlayerId(), (Config.LeoRegenMultiplier or 2.0) * 0.01)
                Wait(500)
            end
        else
            Wait(1000)
        end
    end
end)
