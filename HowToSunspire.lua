-----------------
---- Globals ----
-----------------
HowToSunspire = HowToSunspire or {}
local HowToSunspire = HowToSunspire

HowToSunspire.name = "HowToSunspire"
HowToSunspire.version = "1.4.0"

local WROTHGAR_MAP_INDEX  = 27
local WROTHGAR_MAP_STEP_SIZE = 1.428571431461e-005

local sV
HowToSunspire.groupMembers = {}
---------------------------
---- Variables Default ----
---------------------------
HowToSunspire.Default = {
    OffsetX = {
        HA = 0,
        Portal = 0,
        IceTomb = 0,
        SweepBreath = 0,
        LaserLokke = 0,
        Block = 0,
        Spit = 0,
        Comet = 0,
        Thrash = 0,
        Atro = 0,
        Wipe = 0,
        Storm = 0,
        Geyser = 0,
        NextFlare = 0,
        NextMeteor = 0,
        Negate = 0,
        Shield = 0,
        Cata = 0,
        Leap = 0,
    },
    OffsetY = {
        HA = 0,
        Portal = 50,
        IceTomb = -50,
        SweepBreath = -100,
        LaserLokke = 50,
        Block = 50,
        Spit = -50,
        Comet = -150,
        Thrash = 100,
        Atro = -50,
        Wipe = 150,
        Storm = -100,
        Geyser = 50,
        NextFlare = -100,
        NextMeteor = 150,
        Negate = -50,
        Shield = -50,
        Cata = -50,
        Leap = -50,
    },
    Enable = {
        HA = true,
        Portal = true,
        Interrupt = true,
        Pins = true,
        IceTomb = true,
        SweepBreath = true,
        LaserLokke = true,
        Block = true,
        Spit = true,
        Comet = true,
        Thrash = true,
        Atro = true,
        Wipe = true,
        Storm = true,
        Geyser = true,
        NextFlare = true,
        NextMeteor = true,
        Negate = true,
        Shield = true,
        Cata = true,
        Leap = true,

        AdvancedMeteor = true,
        Sending = false,
    },
    nameStatuesTank = "@Propet4",
    nameMainTank = "@elfoblin",
    nameKiteHeal = "@PatchIGuess",
    FontSize = 40,
    wipeCallLater = 90,
}

----------------------
---- ENTIRE TRIAL ----
----------------------
local listHA = {}
function HowToSunspire.HeavyAttack(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if targetType ~= COMBAT_UNIT_TYPE_PLAYER or hitValue < 100 or sV.Enable.HA ~= true then return end

	if result == ACTION_RESULT_BEGIN then

        --add the HA timer to the table
		table.insert(listHA, GetGameTimeMilliseconds() + hitValue)

        --run all UI functions for HA
        HowToSunspire.HeavyAttackUI()
        Hts_Ha:SetHidden(false)
		PlaySound(SOUNDS.CHAMPION_POINTS_COMMITTED)

		EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HeavyAttackTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "HeavyAttackTimer", 100, HowToSunspire.HeavyAttackUI)
	end
end

function HowToSunspire.HeavyAttackUI()
    local text = ""
    local currentTime = GetGameTimeMilliseconds()

    --create the text to show with the timers
    for key, value in ipairs(listHA) do
        local timer = value - currentTime
        if timer >= 0 then
            if text == "" then
                text = text .. tostring(string.format("%.1f", timer / 1000)) 
            else
                text = text .. "|cff1493 / |r" .. tostring(string.format("%.1f", timer / 1000))
            end
        else
            --remove previous HA from the table
            table.remove(listHA, key)
        end
    end

    --show timers
    if text ~= "" then
        Hts_Ha_Label:SetText("|cff1493HA: |r" .. text)
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HeavyAttackTimer")
        Hts_Ha:SetHidden(true)
    end
end

function HowToSunspire.Block(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN and sV.Enable.Block == true then
        if hitValue > 400 then
            zo_callLater(function ()
                Hts_Block:SetHidden(false)
                PlaySound(SOUNDS.DUEL_START)
                
                EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideBlock")
                EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "HideBlock", 2500, HowToSunspire.HideBlock)
            end, hitValue - 400)
        else
            zo_callLater(function ()
                Hts_Block:SetHidden(false)
                PlaySound(SOUNDS.DUEL_START)
                
                EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideBlock")
                EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "HideBlock", 2500, HowToSunspire.HideBlock)
            end, hitValue)
        end
    end
end

function HowToSunspire.HideBlock()
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideBlock")
    Hts_Block:SetHidden(true)
end

function HowToSunspire.Leap(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN and sV.Enable.Leap == true then
        if hitValue > 400 then
            zo_callLater(function ()
                Hts_Leap:SetHidden(false)
                
                EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideLeap")
                EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "HideLeap", 2500, HowToSunspire.HideLeap)
            end, hitValue - 400)
        else
            zo_callLater(function ()
                Hts_Leap:SetHidden(false)
                
                EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideLeap")
                EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "HideLeap", 2500, HowToSunspire.HideLeap)
            end, hitValue)
        end
    end
end

function HowToSunspire.HideLeap()
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideLeap")
    Hts_Leap:SetHidden(true)
end

local cometTime
local isComet = true
function HowToSunspire.Comet(_, result, _, _, _, _, _, _, targetName, targetType, hitValue, _, _, _, _, targetUnitId, abilityId)
    if abilityId == 117251 or abilityId == 123067 then
        isComet = false
        HowToSunspire.NextMeteor(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
        if sV.Enable.AdvancedMeteor then
            return HowToSunspire.AdvancedMeteor(_, result, _, _, _, _, _, _, targetName, targetType, hitValue, _, _, _, _, targetId, abilityId)
        end
    else
        isComet = true
    end

    if sV.Enable.Comet ~= true or hitValue < 100 or targetType ~= COMBAT_UNIT_TYPE_PLAYER then return end
    if (abilityId == 120359 and result ~= ACTION_RESULT_BEGIN) or
    (abilityId ~= 120359 and result ~= ACTION_RESULT_EFFECT_GAINED_DURATION) then return end

    cometTime = GetGameTimeMilliseconds() + hitValue

    if abilityId == 120359 then
        cometTime = cometTime + 1000
    end

    HowToSunspire.CometUI()
    Hts_Comet:SetHidden(false)
    PlaySound(SOUNDS.DUEL_START)

    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "CometTimer")
    EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "CometTimer", 100, HowToSunspire.CometUI)
end

function HowToSunspire.CometUI()
    local currentTime = GetGameTimeMilliseconds()
    local timer = cometTime - currentTime

    if timer >= 0 then
        if isComet then
            Hts_Comet_Label:SetText("|c87ceebComet: |r" .. tostring(string.format("%.1f", timer / 1000)))
        else
            Hts_Comet_Label:SetText("|cf51414Meteor: |r" .. tostring(string.format("%.1f", timer / 1000)))
        end
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "CometTimer")
        Hts_Comet:SetHidden(true)
    end
end

local shieldChargeTime
function HowToSunspire.ShieldCharge(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN and targetType == COMBAT_UNIT_TYPE_PLAYER and sV.Enable.Shield == true then
        local currentTime = GetGameTimeMilliseconds()
        shieldChargeTime = currentTime + hitValue

        HowToSunspire.ShieldChargeTimerUI()
        Hts_Shield:SetHidden(false)

        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "ShieldChargeTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "ShieldChargeTimer", 100, HowToSunspire.ShieldChargeTimerUI)
    end
end

function HowToSunspire.ShieldChargeTimerUI()
    local currentTime = GetGameTimeMilliseconds()
    local timer = shieldChargeTime - currentTime

    if timer >= 0 then
        Hts_Shield_Label:SetText("|c7fffd4Shield Charge: |r" .. tostring(string.format("%.1f", timer / 1000)))
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "ShieldChargeTimer")
        Hts_Shield:SetHidden(true)
    end
end

--------------------
---- LOKKESTIIZ ----
--------------------
local iceNumber = 0
local prevIce = 0
local iceTime
function HowToSunspire.IceTomb(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN and sV.Enable.IceTomb == true then
        local currentTime = GetGameTimeMilliseconds()
        iceTime = currentTime / 1000 + 13

        if (prevIce + 70000 <= currentTime) or (prevIce + 60000 <= currentTime and iceNumber > 1) then
            iceNumber = 0
        end
        prevIce = currentTime
        iceNumber = iceNumber % 3 + 1

        HowToSunspire.IceTombTimerUI()
        Hts_Ice:SetHidden(false)
        PlaySound(SOUNDS.DUEL_START)

        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "IceTombTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "IceTombTimer", 100, HowToSunspire.IceTombTimerUI)
        
        --update all 1 seconds instead of all 0.1 seconds
        zo_callLater(function ()
            HowToSunspire.IceTombTimerUI()
            EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "IceTombTimer")
            EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "IceTombTimer", 1000, HowToSunspire.IceTombTimerUI)
        end, 4000)

        --events for both ice took
        EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "IceTombFinished", EVENT_EFFECT_CHANGED)
        EVENT_MANAGER:RegisterForEvent(HowToSunspire.name .. "IceTombFinished", EVENT_EFFECT_CHANGED, HowToSunspire.IceTombFinished)
        EVENT_MANAGER:AddFilterForEvent(HowToSunspire.name .. "IceTombFinished", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID, 119638)
    end
end

function HowToSunspire.IceTombTimerUI()
    local currentTime = GetGameTimeMilliseconds() / 1000
    local timer = iceTime - currentTime 

    if timer >= 9 then
        Hts_Ice_Label:SetText("|c00ffffIce |cff0000" .. iceNumber .. "|r |c00ffffin: |r" .. tostring(string.format("%.1f", timer - 9)))
    elseif timer >= 0 then 
        Hts_Ice_Label:SetText("|c00ffffIce |cff0000" .. iceNumber .. "|r |c00ffffremain: |r" .. tostring(string.format("%.0f", timer)))
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "IceTombTimer")
        EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "IceTombFinished", EVENT_EFFECT_CHANGED)
        Hts_Ice:SetHidden(true)
    end
end

local iceState = false
function HowToSunspire.IceTombFinished(_, result, _, _, unitTag, _, _, _, _, _, _, _, _, unitName, _, abilityId, _)
    if result == EFFECT_RESULT_GAINED then
        iceState = true
    elseif result == EFFECT_RESULT_FADED and iceState == true then
        iceState = false

        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "IceTombTimer")
        EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "IceTombFinished", EVENT_EFFECT_CHANGED)
        Hts_Ice:SetHidden(true)
    end
end

local laserTime
function HowToSunspire.LokkeLaser(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN and sV.Enable.LaserLokke == true then
        local currentTime = GetGameTimeMilliseconds()
        if abilityId == 122820 then
            laserTime = currentTime / 1000 + 40
        elseif abilityId == 122821 then
            laserTime = currentTime / 1000 + 10
        elseif abilityId == 122822 then
            laserTime = currentTime / 1000 + 32
        else
            return
        end

        HowToSunspire.LokkeLaserTimerUI()
        Hts_Laser:SetHidden(false)

        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "LokkeLaserTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "LokkeLaserTimer", 1000, HowToSunspire.LokkeLaserTimerUI)
    end
end

function HowToSunspire.LokkeLaserTimerUI()
    local currentTime = GetGameTimeMilliseconds() / 1000
    local timer = laserTime - currentTime

    if timer >= 0 then
        Hts_Laser_Label:SetText("|c7fffd4Laser: |r" .. tostring(string.format("%.0f", timer)))
    else
        Hts_Laser_Label:SetText("|c7fffd4Laser: |rNOW")
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "LokkeLaserTimer")
        zo_callLater(function () Hts_Laser:SetHidden(true) end, 8000)
    end
end

--------------------
---- YOLNAKRIIN ----
--------------------
function HowToSunspire.AtroSpawn(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN and sV.Enable.Atro == true then
        Hts_Atro:SetHidden(false)
        PlaySound(SOUNDS.DUEL_START)

		EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideAtro")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "HideAtro", 4500, HowToSunspire.HideAtro)
    end
end

function HowToSunspire.HideAtro()
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideAtro")
    Hts_Atro:SetHidden(true)
end

function HowToSunspire.LavaGeyser(_, result, _, _, _, _, _, _, targetName, targetType, hitValue, _, _, _, _, targetId, abilityId)
    if result == ACTION_RESULT_BEGIN and sV.Enable.Geyser == true then
        if targetType == COMBAT_UNIT_TYPE_PLAYER then
            Hts_Geyser:SetHidden(false)
            PlaySound(SOUNDS.DUEL_START)

            EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideGeyser")
            EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "HideGeyser", 2500, HowToSunspire.HideGeyser)
        elseif HowToSunspire.groupMembers[targetId].tag then 
            --copied from CCA
		    SetMapToPlayerLocation()
            local x1, y1 = GetMapPlayerPosition("player")
            local x2, y2 = GetMapPlayerPosition(HowToSunspire.groupMembers[targetId].tag)
            if (math.sqrt((x1 - x2)^2 + (y1 - y2)^2) * 1000) < 2.8 then
                Hts_Geyser:SetHidden(false)
                PlaySound(SOUNDS.DUEL_START)
        
                EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideGeyser")
                EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "HideGeyser", 2500, HowToSunspire.HideGeyser)
            end
        end
    end
end

function HowToSunspire.HideGeyser()
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideGeyser")
    Hts_Geyser:SetHidden(true)
end

local nextFlareTime
function HowToSunspire.NextFlare(_, result, _, _, _, _, _, _, targetName, targetType, hitValue, _, _, _, _, targetId, abilityId)
    if not sV.Enable.NextFlare then return end

    if abilityId == 121722 and result == ACTION_RESULT_BEGIN then
        nextFlareTime = GetGameTimeMilliseconds() / 1000 + 32
    elseif abilityId == 121459 and result == ACTION_RESULT_EFFECT_FADED then   
        nextFlareTime = GetGameTimeMilliseconds() / 1000 + 30
    elseif abilityId == nil and result == nil and targetName == nil and targetType == nil and hitValue == nil and targetId == nil then 
        --from fight begin
        nextFlareTime = GetGameTimeMilliseconds() / 1000 + 6
    else
        return
    end

    HowToSunspire.NextFlareUI()
    Hts_NextFlare:SetHidden(false)

    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "NextFlareTimer")
    EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "NextFlareTimer", 1000, HowToSunspire.NextFlareUI)
end

function HowToSunspire.NextFlareUI()
    local currentTime = GetGameTimeMilliseconds() / 1000
    local timer = nextFlareTime - currentTime

    if timer >= 0 then
        Hts_NextFlare_Label:SetText("|ce51919Next Flare: |r" .. tostring(string.format("%.0f", timer)))
    else
        Hts_NextFlare_Label:SetText("|ce51919Next Flare: |rINC")
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "NextFlareTimer")
        --Hts_NextFlare:SetHidden(true)
    end
end

local cataTime
function HowToSunspire.Cata(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN and sV.Enable.Cata == true then
        local currentTime = GetGameTimeMilliseconds()
        cataTime = currentTime + hitValue

        HowToSunspire.CataTimerUI()
        Hts_Cata:SetHidden(false)

        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "CataTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "CataTimer", 100, HowToSunspire.CataTimerUI)
    end
end

function HowToSunspire.CataTimerUI()
    local currentTime = GetGameTimeMilliseconds()
    local timer = cataTime - currentTime

    if timer >= 0 then
        Hts_Cata_Label:SetText("|ce51919Cataclysm Ends in: |r" .. tostring(string.format("%.1f", timer / 1000)))
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "CataTimer")
        Hts_Cata:SetHidden(true)
    end
end

---------------------
---- NAHVIINTAAS ----
---------------------
local rightToLeft
function HowToSunspire.SweepingBreath(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN and sV.Enable.SweepBreath == true then
        if abilityId == 118743 then
            rightToLeft = true
        else
            rightToLeft = false
        end

        --run all UI functions for HA
        HowToSunspire.SweepingBreathUI()
        Hts_Sweep:SetHidden(false)
		PlaySound(SOUNDS.DUEL_START)

		EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "SweepingBreath")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "SweepingBreath", 100, HowToSunspire.SweepingBreathUI)
        
        --hide 5sec later
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "HideSweepingBreath", 5000, HowToSunspire.HideSweepingBreath)
    end
end

local flash = 0
local function GetArrowForSweepingBreath()
    flash = flash % 4 + 1

    if rightToLeft then
        if flash == 1 then
            return "<<|cffa500<|r|cff0000<|r"
        elseif flash == 2 then
            return "<|cffa500<|r|cff0000<|r|cffa500<|r"
        elseif flash == 3 then
            return "|cffa500<|r|cff0000<|r|cffa500<|r<"
        else
            return "|cff0000<|r|cffa500<|r<<"
        end
    else
        if flash == 1 then
            return "|cff0000>|r|cffa500>|r>>"
        elseif flash == 2 then
            return "|cffa500>|r|cff0000>|r|cffa500>|r>"
        elseif flash == 3 then
            return ">|cffa500>|r|cff0000>|r|cffa500>|r"
        else
            return ">>|cffa500>|r|cff0000>|r"
        end
    end
end
function HowToSunspire.SweepingBreathUI()
    local arrow = GetArrowForSweepingBreath()

    Hts_Sweep_Label:SetText(arrow .. " Sweep Breath " .. arrow)
end

function HowToSunspire.HideSweepingBreath()
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideSweepingBreath")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "SweepingBreath")
    Hts_Sweep:SetHidden(true)
end

local spitTime
function HowToSunspire.FireSpit(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if targetType ~= COMBAT_UNIT_TYPE_PLAYER or hitValue < 300 or sV.Enable.Spit ~= true then return end

	if result == ACTION_RESULT_BEGIN then
        spitTime = GetGameTimeMilliseconds() + hitValue
        
        if abilityId == 118860 then
            spitTime = spitTime + 900
        else
            spitTime = spitTime + 700
        end

        HowToSunspire.FireSpitUI()
        Hts_Spit:SetHidden(false)
		PlaySound(SOUNDS.CHAMPION_POINTS_COMMITTED)

		EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "FireSpitTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "FireSpitTimer", 100, HowToSunspire.FireSpitUI)
	end
end

function HowToSunspire.FireSpitUI()
    local currentTime = GetGameTimeMilliseconds()
    local timer = spitTime - currentTime

    if timer >= 0 then
        Hts_Spit_Label:SetText("|cff1493Spit: |r" .. tostring(string.format("%.1f", timer / 1000)))
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "FireSpitTimer")
        Hts_Spit:SetHidden(true)
    end
end

local thrashTime
local nextMeteorTime
function HowToSunspire.Thrash(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN and sV.Enable.Thrash == true then
        local currentTime = GetGameTimeMilliseconds()
        thrashTime = currentTime + hitValue

        HowToSunspire.ThrashTimerUI()
        PlaySound(SOUNDS.CHAMPION_POINTS_COMMITTED)
        Hts_Thrash:SetHidden(false)

        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "ThrashTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "ThrashTimer", 100, HowToSunspire.ThrashTimerUI)

        nextMeteorTime = nextMeteorTime - 1.5
    end
end

function HowToSunspire.ThrashTimerUI()
    local currentTime = GetGameTimeMilliseconds()
    local timer = thrashTime - currentTime

    if timer >= 0 then
        Hts_Thrash_Label:SetText("|ce51919Thrash: |r" .. tostring(string.format("%.1f", timer / 1000)))
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "ThrashTimer")
        Hts_Thrash:SetHidden(true)
    end
end

function HowToSunspire.NextMeteor(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if not sV.Enable.NextMeteor then return end

    if (abilityId == 117251 or abilityId == 123067) and result == ACTION_RESULT_EFFECT_GAINED_DURATION then
        nextMeteorTime = GetGameTimeMilliseconds() / 1000 + 14.5
    elseif abilityId == 117308 and result == ACTION_RESULT_BEGIN then
        nextMeteorTime = GetGameTimeMilliseconds() / 1000 + 10.5
    else
        return
    end
    HowToSunspire.NextMeteorUI()
    Hts_NextMeteor:SetHidden(false)

    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "NextMeteorTimer")
    EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "NextMeteorTimer", 1000, HowToSunspire.NextMeteorUI)
end

function HowToSunspire.NextMeteorUI()
    local currentTime = GetGameTimeMilliseconds() / 1000
    local timer = nextMeteorTime - currentTime

    if timer >= 0 then
        Hts_NextMeteor_Label:SetText("|cf51414Next Meteor: |r" .. tostring(string.format("%.0f", timer)))
    else
        Hts_NextMeteor_Label:SetText("|cf51414Next Meteor: |rINC")
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "NextMeteorTimer")
        --Hts_NextMeteor:SetHidden(true)
    end
end

function HowToSunspire.MarkForDeath(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN then
        nextMeteorTime = nextMeteorTime + 1.5
    end
end

--found on stackoverflow
local function spairs(t)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    table.sort(keys)

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

local function fillPosToDrop(posToDrop, name)
    if posToDrop["right"] == nil then
        posToDrop["right"] = name
    elseif posToDrop["back"] == nil then
        posToDrop["back"] = name
    else
        posToDrop["left"] = name
    end
    return posToDrop
end

local listUserMeteor
local cptUserMeteor
local posToDrop = {}
function HowToSunspire.AdvancedMeteor(_, result, _, _, _, _, _, _, targetName, targetType, hitValue, _, _, _, _, targetId, abilityId)
    if listUserMeteor == nil or cptUserMeteor >= 3 then
        listUserMeteor = {}
        cptUserMeteor = 0
    end

    if HowToSunspire.groupMembers[targetId].tag then 
        cptUserMeteor = cptUserMeteor + 1
        cometTime = GetGameTimeMilliseconds() + hitValue
        listUserMeteor[HowToSunspire.groupMembers[targetId].name] = GetGroupMemberSelectedRole(HowToSunspire.groupMembers[targetId].tag)
    end

    if cptUserMeteor < 3 then return end

    local retour = true
    posToDrop = {
        ["right"] = nil,
        ["back"]  = nil,
        ["left"]  = nil
    }
    --Priority is for the statues tank
    for key, value in spairs(listUserMeteor) do
        if key == sV.nameStatuesTank then
            posToDrop.back = key
        end
        if key == GetUnitDisplayName("player") then
            retour = false
        end
    end
    --if player isnt part of the players with meteor on him
    if retour then return end
    --Then for the main tank
    for key, value in spairs(listUserMeteor) do
        if key == sV.nameMainTank then
            posToDrop = fillPosToDrop(posToDrop, key)
        end
    end
    --Then for the kite heal
    for key, value in spairs(listUserMeteor) do
        if key == sV.nameKiteHeal then
            posToDrop = fillPosToDrop(posToDrop, key)
        end
    end
    --Then come other tanks and heals
    for key, value in spairs(listUserMeteor) do
        if value == LFG_ROLE_HEAL or value == LFG_ROLE_TANK then
            posToDrop = fillPosToDrop(posToDrop, key)
        end
    end
    --Then the dds
    for key, value in spairs(listUserMeteor) do
        posToDrop = fillPosToDrop(posToDrop, key)
    end

    HowToSunspire.AdvancedMeteorUI()
    Hts_Comet:SetHidden(false)
    PlaySound(SOUNDS.DUEL_START)

    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "CometTimer")
    EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "CometTimer", 100, HowToSunspire.AdvancedMeteorUI)
end

function HowToSunspire.AdvancedMeteorUI()
    local currentTime = GetGameTimeMilliseconds()
    local timer = cometTime - currentTime
    local position

    for key, value in pairs(posToDrop) do
        if value == GetUnitDisplayName("player") then
            position = key
        end
    end

    local header, footer
    if position == "right" then
        header = ">>>>> "
        footer = " >>>>>"
    elseif position == "left" then
        header = "<<<<< "
        footer = " <<<<<"
    elseif position == "back" then
        header = "^^^^^ "
        footer = " ^^^^^"
    end

    if timer >= 0 then
        Hts_Comet_Label:SetText("|cf51414" .. header .. "Meteor: |r" .. tostring(string.format("%.1f", timer / 1000)) .. "|cf51414" .. footer .. "|r")
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "CometTimer")
        Hts_Comet:SetHidden(true)
    end
end

------------------------
---- LAST DOWNSTAIR ----
------------------------
local portalTime
local wipeTime
local canSend = false
local canReceive = false
function HowToSunspire.Portal(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result ~= ACTION_RESULT_BEGIN then return end
    canSend = true

    if sV.Enable.Portal == true then
        portalTime = GetGameTimeMilliseconds() / 1000 + 14

        HowToSunspire.PortalTimerUI()
        Hts_Down:SetHidden(false)
		PlaySound(SOUNDS.TELVAR_GAINED)

		EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "PortalTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "PortalTimer", 1000, HowToSunspire.PortalTimerUI)
    end

    if sV.Enable.Wipe then
        wipeTime = GetGameTimeMilliseconds() / 1000 + 98

        local callLater = (93 - sV.wipeCallLater) * 1000
        zo_callLater(function()
            Hts_Wipe:SetHidden(false)
            EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "WipeTimer")
            EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "WipeTimer", 1000, HowToSunspire.WipeTimerUI)
        end, callLater)

        EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "WipeFinished", EVENT_COMBAT_EVENT)
        EVENT_MANAGER:RegisterForEvent(HowToSunspire.name .. "WipeFinished", EVENT_COMBAT_EVENT, HowToSunspire.WipeFinished)
        EVENT_MANAGER:AddFilterForEvent(HowToSunspire.name .. "WipeFinished", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, 121216)
    end
end

function HowToSunspire.PortalTimerUI()
    local currentTime = GetGameTimeMilliseconds() / 1000
    local timer = portalTime - currentTime

    if timer >= 11 then 
        Hts_Down_Label:SetText("|c7fffd4Portal: |r|cff0000" .. tostring(string.format("%.0f", timer)) .. "|r")
    elseif timer >= 0 then
        Hts_Down_Label:SetText("|c7fffd4Portal: |r" .. tostring(string.format("%.0f", timer)))
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "PortalTimer")
        Hts_Down:SetHidden(true)
    end
end

function HowToSunspire.WipeTimerUI()
    local currentTime = GetGameTimeMilliseconds() / 1000
    local timer = wipeTime - currentTime

    if timer >= 0 then
        Hts_Wipe_Label:SetText("|c8a2be2Wipe Down: |r" .. tostring(string.format("%.0f", timer)))
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "WipeTimer")
        Hts_Wipe:SetHidden(true)
    end
end

function HowToSunspire.WipeFinished(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_EFFECT_FADED then
        EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "WipeFinished", EVENT_COMBAT_EVENT)
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "WipeTimer")
        Hts_Wipe:SetHidden(true)
        if LibMapPing then
            LibMapPing:RemoveMapPing(MAP_PIN_TYPE_PING)
        end
    end
end

--local downstair = false
local cptDownstair = 0
function HowToSunspire.IsDownstair(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if targetType == COMBAT_UNIT_TYPE_GROUP then
        cptDownstair = cptDownstair + 1
    elseif targetType ~= COMBAT_UNIT_TYPE_PLAYER then
        return
    end
    
    if result == ACTION_RESULT_EFFECT_GAINED_DURATION or cptDownstair == 3 then
        --downstair = true
        cptDownstair = 0
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "PortalTimer")
        Hts_Down:SetHidden(true)
    end
end

function HowToSunspire.IsUpstair(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    --Unregister for all down relative events
    if result == ACTION_RESULT_EFFECT_GAINED_DURATION and targetType == COMBAT_UNIT_TYPE_PLAYER then
        --downstair = false
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "InterruptTimer")
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "PinsTimer")
        EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "Pins", EVENT_COMBAT_EVENT)
        Hts_Down:SetHidden(true)
    end
end

local interruptTime
local interruptUnitId
function HowToSunspire.InterruptDown(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, targetUnitId, abilityId)
    if result ~= ACTION_RESULT_EFFECT_GAINED_DURATION --[[or downstair ~= true]] then return end
    canReceive = true
    if LibMapPing then
        LibMapPing:RegisterCallback("BeforePingAdded", HowToSunspire.OnMapPing)
    end

    if sV.Enable.Pins == true then
        --register for when it is bashed
        EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "Pins", EVENT_COMBAT_EVENT)
        EVENT_MANAGER:RegisterForEvent(HowToSunspire.name .. "Pins", EVENT_COMBAT_EVENT, HowToSunspire.PinsDown) --interrupt down
        EVENT_MANAGER:AddFilterForEvent(HowToSunspire.name .. "Pins", EVENT_COMBAT_EVENT, REGISTER_FILTER_COMBAT_RESULT, ACTION_RESULT_INTERRUPT)
    end

    if sV.Enable.Interrupt == true then
        --add the HA timer to the table
        interruptTime = GetGameTimeMilliseconds() + hitValue
        interruptUnitId = targetUnitId

        --run all UI functions for HA
        HowToSunspire.InterruptTimerUI()
        Hts_Down:SetHidden(false)

		EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "InterruptTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "InterruptTimer", 100, HowToSunspire.InterruptTimerUI)
    end
end

function HowToSunspire.InterruptTimerUI()
    local currentTime = GetGameTimeMilliseconds()
    local timer = interruptTime - currentTime

    if timer >= 0 then
        Hts_Down_Label:SetText("|c7fffd4Interrupt: |r" .. tostring(string.format("%.1f", timer / 1000)))
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "InterruptTimer")
        Hts_Down:SetHidden(true)
    end
end

local pinsTime
function HowToSunspire.PinsDown(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, targetUnitId, abilityId)
    --stop the timer of interrupt
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "InterruptTimer")

    if interruptUnitId == targetUnitId then
        interruptUnitId = nil
        pinsTime = GetGameTimeMilliseconds() / 1000 + 20

        --run all UI functions for HA
        HowToSunspire.PinsTimerUI()
        Hts_Down:SetHidden(false)

        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "PinsTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "PinsTimer", 1000, HowToSunspire.PinsTimerUI)
    end
end

function HowToSunspire.PinsTimerUI()
    local currentTime = GetGameTimeMilliseconds() / 1000
    local timer = pinsTime - currentTime

    if timer >= 0 then
        Hts_Down_Label:SetText("|c7fffd4Next Pins: |r" .. tostring(string.format("%.0f", timer)))
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "PinsTimer")
        Hts_Down:SetHidden(true)
    end
end

function HowToSunspire.NegateField(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, _, abilityId)
    if result == ACTION_RESULT_BEGIN and targetType == COMBAT_UNIT_TYPE_PLAYER and sV.Enable.Negate == true then
        Hts_Negate:SetHidden(false)
        PlaySound(SOUNDS.DUEL_START)

		EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideNegate")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "HideNegate", 2500, HowToSunspire.HideNegate)
    end
end

function HowToSunspire.HideNegate()
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideNegate")
    Hts_Negate:SetHidden(true)
end

----------------------------------
---- SHARE PART FOR EXPLOSION ----
----------------------------------
-- see https://i.ytimg.com/vi/O4tbOvKwZUw/maxresdefault.jpg
local stormTime
local firstStormTrigger = true
function HowToSunspire.FireStorm(_, result, _, _, _, _, _, _, _, targetType, hitValue, _, _, _, _, targetUnitId, abilityId)
    if result ~= ACTION_RESULT_BEGIN then return end

    if firstStormTrigger == true then
        firstStormTrigger = false
        return
    end
    firstStormTrigger = true

    if sV.Enable.Storm == true then
        stormTime = GetGameTimeMilliseconds() / 1000 + 13.7

        HowToSunspire.FireStormUI()
        Hts_Storm:SetHidden(false)

        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "FireStormTimer")
        EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "FireStormTimer", 100, HowToSunspire.FireStormUI)
    end

    if canSend and LibGPS2 and LibMapPing and sV.Enable.Sending then
        canSend = false

        local LGPS = LibGPS2
        local LMP = LibMapPing
        LGPS:PushCurrentMap()
        SetMapToMapListIndex(WROTHGAR_MAP_INDEX)
    
        local x = 42 * WROTHGAR_MAP_STEP_SIZE
        local y = 42 * WROTHGAR_MAP_STEP_SIZE
        LMP:SetMapPing(MAP_PIN_TYPE_PING, MAP_TYPE_LOCATION_CENTERED, x, y)
        LGPS:PopCurrentMap()
    end
end

function HowToSunspire.FireStormUI()
    local currentTime = GetGameTimeMilliseconds() / 1000
    local timer = stormTime - currentTime

    if timer >= 5.2 then
        Hts_Storm_Label:SetText("|ce51919Fire Storm in: |r" .. tostring(string.format("%.1f", timer - 5.2)))
    elseif timer >= 0 then
        Hts_Storm_Label:SetText("|ce51919Fire Storm remain: |r" .. tostring(string.format("%.1f", timer)))
    else
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "FireStormTimer")
        Hts_Storm:SetHidden(true)
    end
end

function HowToSunspire.OnMapPing(pingType, pingTag, _, _, isLocalPlayerOwner)
    if not canReceive or not LibGPS2 or not LibMapPing or isLocalPlayerOwner or not sV.Enable.Storm then return end
    
    local LGPS = LibGPS2
    local LMP = LibMapPing

    if pingType == MAP_PIN_TYPE_PING then
		LGPS:PushCurrentMap()
		SetMapToMapListIndex(WROTHGAR_MAP_INDEX)
        local x, y = LMP:GetMapPing(MAP_PIN_TYPE_PING, pingTag)

        if LMP:IsPositionOnMap(x, y) then
            --d("Enter in Received Function")
            canSend = false
            x = math.floor(x / WROTHGAR_MAP_STEP_SIZE)
            y = math.floor(y / WROTHGAR_MAP_STEP_SIZE)
            --d("X= " .. x .. " Y= " .. y)
            if x == 42 and y == 42 then
                canReceive = false
                LibMapPing:UnregisterCallback("BeforePingAdded", HowToSunspire.OnMapPing)

                stormTime = GetGameTimeMilliseconds() / 1000 + 13.7

                HowToSunspire.FireStormUI()
                Hts_Storm:SetHidden(false)

                EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "FireStormTimer")
                EVENT_MANAGER:RegisterForUpdate(HowToSunspire.name .. "FireStormTimer", 100, HowToSunspire.FireStormUI)
            end
        end
        LGPS:PopCurrentMap()
    end
end
--------------
---- INIT ----
--------------
function HowToSunspire.ResetAll()
    --hide everything
    Hts_Ha:SetHidden(true)
    Hts_Down:SetHidden(true)
    Hts_Ice:SetHidden(true)
    Hts_Sweep:SetHidden(true)
    Hts_Laser:SetHidden(true)
    Hts_Block:SetHidden(true)
    Hts_Spit:SetHidden(true)
    Hts_Comet:SetHidden(true)
    Hts_Thrash:SetHidden(true)
    Hts_Atro:SetHidden(true)
    Hts_Wipe:SetHidden(true)
    Hts_Storm:SetHidden(true)
    Hts_Geyser:SetHidden(true)
    Hts_Negate:SetHidden(true)
    Hts_Shield:SetHidden(true)
    Hts_Cata:SetHidden(true)
    Hts_Leap:SetHidden(true)

    Hts_NextFlare:SetHidden(true)
    Hts_NextMeteor:SetHidden(true)
    zo_callLater(function()
        Hts_NextFlare:SetHidden(true)
        Hts_NextMeteor:SetHidden(true)
    end, 3000)

    --unregister UI timer events
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HeavyAttackTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideBlock")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideLeap")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "CometTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "ShieldChargeTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "IceTombTimer")
    EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "IceTombFinished", EVENT_EFFECT_CHANGED)
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "LokkeLaserTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideAtro")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideGeyser")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "NextFlareTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideSweepingBreath")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "SweepingBreath")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "FireSpitTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "ThrashTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "NextMeteorTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "PortalTimer")
    EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "WipeFinished", EVENT_COMBAT_EVENT)
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "WipeTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "InterruptTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "PinsTimer")
    EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "Pins", EVENT_COMBAT_EVENT)
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "HideNegate")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "FireStormTimer")
    EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "CataTimer")

    --[[if LibMapPing then
        LibMapPing:RemoveMapPing(MAP_PIN_TYPE_PING)
    end]]
    HowToSunspire.groupMembers = {}

    --reset variables
    listHA = {}
    cometTime = 0
    iceNumber = 0
    prevIce = 0
    iceTime = 0
    isComet = true
    shieldChargeTime = 0
    iceState = false
    laserTime = 0
    rightToLeft = 0
    flash = 0
    spitTime = 0
    nextFlareTime = 0
    thrashTime = 0
    nextMeteorTime = 0
    portalTime = 0
    wipeTime = 0
    cptDownstair = 0
    interruptTime = 0
    interruptUnitId = nil
    pinsTime = 0
    stormTime = 0
    canReceive = false
    canSend = false
    firstStormTrigger = true
    cataTime = 0
    listUserMeteor = nil
    cptUserMeteor = 0
    posToDrop = {}

end

function HowToSunspire.GetGroupTags(_, _, _, _, unitTag, _, _, _, _, _, _, _, _, unitName, unitId, _, _)
    if not HowToSunspire.groupMembers[unitId] then
		HowToSunspire.groupMembers[unitId] = {
			tag = unitTag,
			name = GetUnitDisplayName(unitTag) or unitName,
		}
	end
end

function HowToSunspire.CombatState()
    if IsUnitInCombat("player") and GetUnitName("boss1") == "Yolnahkriin" then
        HowToSunspire.NextFlare(_, nil, _, _, _, _, _, _, nil, nil, nil, _, _, _, _, nil, nil)
    end

    --on combat ended
    zo_callLater(function() 
        if (not IsUnitInCombat("player")) then 
            HowToSunspire.ResetAll()
        end
    end, 3000)
end

function HowToSunspire.OnPlayerActivated()
    
    if GetZoneId(GetUnitZoneIndex("player")) == 1121 then --in Sunspire
        for k, v in pairs(HowToSunspire.AbilitiesToTrack) do --Register for abilities in the other lua file
            EVENT_MANAGER:RegisterForEvent(HowToSunspire.name .. "Ability" .. k, EVENT_COMBAT_EVENT, v)
            EVENT_MANAGER:AddFilterForEvent(HowToSunspire.name .. "Ability" .. k, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, k)
        end
        EVENT_MANAGER:RegisterForEvent(HowToSunspire.name .. "CombatState", EVENT_PLAYER_COMBAT_STATE, HowToSunspire.CombatState)
        EVENT_MANAGER:RegisterForEvent(HowToSunspire.name .. "GroupTags", EVENT_EFFECT_CHANGED, HowToSunspire.GetGroupTags)
        EVENT_MANAGER:AddFilterForEvent(HowToSunspire.name .. "GroupTags", EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG_PREFIX, "group")

        HowToSunspire.ResetAll()
    else
        for k, v in pairs(HowToSunspire.AbilitiesToTrack) do --Unregister for all abilities
            EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "Ability" .. k, EVENT_COMBAT_EVENT)
        end
        EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name .. "CombatState", EVENT_PLAYER_COMBAT_STATE)
        EVENT_MANAGER:UnregisterForUpdate(HowToSunspire.name .. "GroupTags", EVENT_EFFECT_CHANGED)
    end

end

function HowToSunspire:Initialize()
	--Saved Variables
    HowToSunspire.savedVariables = ZO_SavedVars:NewAccountWide("HowToSunspireVariables", 2, nil, HowToSunspire.Default)
    sV = HowToSunspire.savedVariables
	--Settings
	HowToSunspire.CreateSettingsWindow()
	--UI
    HowToSunspire.InitUI()

    if LibMapPing then 
        LibMapPing:MutePing(MAP_PIN_TYPE_PING)
    end

    --Events
    EVENT_MANAGER:RegisterForEvent(HowToSunspire.name .. "Activated", EVENT_PLAYER_ACTIVATED, HowToSunspire.OnPlayerActivated)

    EVENT_MANAGER:UnregisterForEvent(HowToSunspire.name, EVENT_ADD_ON_LOADED)
end

function HowToSunspire.OnAddOnLoaded(event, addonName)
	if addonName ~= HowToSunspire.name then return end
        HowToSunspire:Initialize()
end

EVENT_MANAGER:RegisterForEvent(HowToSunspire.name, EVENT_ADD_ON_LOADED, HowToSunspire.OnAddOnLoaded)
