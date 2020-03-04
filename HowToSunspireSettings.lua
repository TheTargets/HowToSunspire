HowToSunspire = HowToSunspire or {}
local HowToSunspire = HowToSunspire

local LAM2 = LibAddonMenu2

function HowToSunspire.CreateSettingsWindow()
	local panelData = {
		type = "panel",
		name = "HowToSunspire",
		displayName = "HowTo|c989898Sunspire|r",
		author = "Floliroy",
		version = HowToSunspire.version,
		slashCommand = "/HowToSunspire",
		registerForRefresh = true,
		registerForDefaults = true,
	}
	
	local cntrlOptionsPanel = LAM2:RegisterAddonPanel("HowToSunspire_Settings", panelData)
	local Unlock = {
		Everything = false,
		HA = false,
		Portal = false,
		IceTomb = false,
		SweepBreath = false,
		LaserLokke = false,
		Block = false,
		Spit = false,
		Comet = false,
		Thrash = false,
		Atro = false,
		Wipe = false,
		Storm = false,
		Geyser = false,
		NextFlare = false,
		NextMeteor = false,
		Negate = false,
		Shield = false,
        Cata = false,
        Leap = false,
	}

	local sV = HowToSunspire.savedVariables
	local optionsData = {
		{
			type = "header",
			name = "User Interface",
		},
		{	type = "description",
			text = "Change settings and notification positions here.",
		},
		{	type = "submenu",
			name = "Unlock Positions",
			controls = {
				{	type = "checkbox",
					name = "Unlock Everything",
					tooltip = "Use it to set the position of all the notifications.",
					default = false,
					getFunc = function() return Unlock.Everything end,
					setFunc = function(newValue)
						Unlock.Everything = newValue
						Hts_Ha:SetHidden(not newValue)
						Hts_Block:SetHidden(not newValue)
						Hts_Ice:SetHidden(not newValue)
						Hts_Laser:SetHidden(not newValue)
						Hts_Sweep:SetHidden(not newValue)
						Hts_Down:SetHidden(not newValue)
						Hts_Spit:SetHidden(not newValue)
						Hts_Comet:SetHidden(not newValue)
						Hts_Atro:SetHidden(not newValue)
						Hts_Thrash:SetHidden(not newValue)
						Hts_Wipe:SetHidden(not newValue)
						Hts_Storm:SetHidden(not newValue)
						Hts_Geyser:SetHidden(not newValue)
						Hts_NextFlare:SetHidden(not newValue)
						Hts_NextMeteor:SetHidden(not newValue)
						Hts_Negate:SetHidden(not newValue)
						Hts_Shield:SetHidden(not newValue)
						Hts_Cata:SetHidden(not newValue)
						Hts_Leap:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock HA",
					tooltip = "Use it to set the position of the Heavy Attacks timer text.",
					default = false,
					getFunc = function() return Unlock.HA end,
					setFunc = function(newValue)
						Unlock.HA = newValue
						Hts_Ha:SetHidden(not newValue)  
					end,
				},
				{	type = "checkbox",
					name = "Unlock Jode´s Fire-Fang Jump",
					tooltip = "Use it to set the position of the Block text.",
					default = false,
					getFunc = function() return Unlock.Block end,
					setFunc = function(newValue)
						Unlock.Block = newValue
						Hts_Block:SetHidden(not newValue)  
					end,
				},
				{	type = "checkbox",
					name = "Unlock Leap",
					tooltip = "Use it to set the position of the Leap text.",
					default = false,
					getFunc = function() return Unlock.Leap end,
					setFunc = function(newValue)
						Unlock.Leap = newValue
						Hts_Leap:SetHidden(not newValue)  
					end,
				},
				{	type = "checkbox",
					name = "Unlock Comet / Meteor",
					tooltip = "Use it to set the position of the Comet and Meteor notifications.",
					default = false,
					getFunc = function() return Unlock.Comet end,
					setFunc = function(newValue)
						Unlock.Comet = newValue
						Hts_Comet:SetHidden(not newValue)  
					end,
				},
				{	type = "checkbox",
					name = "Unlock Shield Charge",
					tooltip = "Use it to set the position of the Shield Charge alert.",
					default = false,
					getFunc = function() return Unlock.Shield end,
					setFunc = function(newValue)
						Unlock.Shield = newValue
						Hts_Shield:SetHidden(not newValue)  
					end,
				},
				{	type = "checkbox",
					name = "Unlock Ice Tomb",
					tooltip = "Use it to set the position of the Ice Tomb timer.",
					default = false,
					getFunc = function() return Unlock.IceTomb end,
					setFunc = function(newValue)
						Unlock.IceTomb = newValue
						Hts_Ice:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Laser",
					tooltip = "Use it to set the position of the Laser that you have to block.",
					default = false,
					getFunc = function() return Unlock.LaserLokke end,
					setFunc = function(newValue)
						Unlock.LaserLokke = newValue
						Hts_Laser:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Fire Atro Spawn",
					tooltip = "Use it to set the position of the Fire Atro spawn text.",
					default = false,
					getFunc = function() return Unlock.Atro end,
					setFunc = function(newValue)
						Unlock.Atro = newValue
						Hts_Atro:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Lava Geyser",
					tooltip = "Use it to set the position of the Lava Geyser notification.",
					default = false,
					getFunc = function() return Unlock.Geyser end,
					setFunc = function(newValue)
						Unlock.Geyser = newValue
						Hts_Geyser:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Next Flare",
					tooltip = "Use it to set the position of the Next Flare timer.",
					default = false,
					getFunc = function() return Unlock.NextFlare end,
					setFunc = function(newValue)
						Unlock.NextFlare = newValue
						Hts_NextFlare:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Sweeping Breath",
					tooltip = "Use it to set the position of the Sweeping Breath.",
					default = false,
					getFunc = function() return Unlock.SweepBreath end,
					setFunc = function(newValue)
						Unlock.SweepBreath = newValue
						Hts_Sweep:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Thrash",
					tooltip = "Use it to set the position of the Thrash.",
					default = false,
					getFunc = function() return Unlock.Thrash end,
					setFunc = function(newValue)
						Unlock.Thrash = newValue
						Hts_Thrash:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Fire Spit",
					tooltip = "Use it to set the position of the Fire Spit that will pop an atronach.",
					default = false,
					getFunc = function() return Unlock.Spit end,
					setFunc = function(newValue)
						Unlock.Spit = newValue
						Hts_Spit:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Fire Storm",
					tooltip = "Use it to set the position of the Fire Storm.",
					default = false,
					getFunc = function() return Unlock.Storm end,
					setFunc = function(newValue)
						Unlock.Storm = newValue
						Hts_Storm:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Wipe Countdown",
					tooltip = "Use it to set the position of the Wipe countdown.",
					default = false,
					getFunc = function() return Unlock.Wipe end,
					setFunc = function(newValue)
						Unlock.Wipe = newValue
						Hts_Wipe:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Next Meteor",
					tooltip = "Use it to set the position of the Next Meteor timer.",
					default = false,
					getFunc = function() return Unlock.NextMeteor end,
					setFunc = function(newValue)
						Unlock.NextMeteor = newValue
						Hts_NextMeteor:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Portals Notification",
					tooltip = "Use it to set the position of all the Downstairs notifications.",
					default = false,
					getFunc = function() return Unlock.Portal end,
					setFunc = function(newValue)
						Unlock.Portal = newValue
						Hts_Down:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Negate Notification",
					tooltip = "Use it to set the position of Negate notification while downstair.",
					default = false,
					getFunc = function() return Unlock.Negate end,
					setFunc = function(newValue)
						Unlock.Negate = newValue
						Hts_Negate:SetHidden(not newValue)
					end,
				},
				{	type = "checkbox",
					name = "Unlock Cataclysm",
					tooltip = "Use it to set the position of the cataclysm.",
					default = false,
					getFunc = function() return Unlock.Cata end,
					setFunc = function(newValue)
						Unlock.Cata = newValue
						Hts_Cata:SetHidden(not newValue)
					end,
				},
			},
		},
		{	type = "slider",
            name = "Notifications Size",
            tooltip = "Choose here the size of all the notifications.",
            getFunc = function() return sV.FontSize end,
            setFunc = function(newValue)
				sV.FontSize = newValue
				HowToSunspire.SetFontSize(Hts_Ha_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Down_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Ice_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Sweep_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Laser_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Block_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Spit_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Comet_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Thrash_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Atro_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Wipe_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Storm_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Geyser_Label, newValue)
				HowToSunspire.SetFontSize(Hts_NextFlare_Label, newValue)
				HowToSunspire.SetFontSize(Hts_NextMeteor_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Negate_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Shield_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Cata_Label, newValue)
				HowToSunspire.SetFontSize(Hts_Leap_Label, newValue)
			end,
            min = 32,
            max = 56,
            step = 2,
            default = 40,
            width = "full",
		},
		{
			type = "header",
			name = "Global Notifications",
		},
		{	type = "description",
			text = "Edit trialwide mechanics here.",
		},
		{	type = "checkbox",
			name = "Enable HA Tracking",
			tooltip = "Tracks all Heavy Attacks including bosses and the eternal servant.",
			default = true,
			getFunc = function() return sV.Enable.HA end,
			setFunc = function(newValue)  
				sV.Enable.HA = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Jode´s Fire-Fang Jump",
			tooltip = "Tracks the red cats Jump that you have to block.",
			default = true,
			getFunc = function() return sV.Enable.Block end,
			setFunc = function(newValue)  
				sV.Enable.Block = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Leap",
			tooltip = "Tracks the 2h adds leap that you have to block.",
			default = true,
			getFunc = function() return sV.Enable.Leap end,
			setFunc = function(newValue)  
				sV.Enable.Leap = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Comet / Meteor",
			tooltip = "Tracks ALL Meteors and Comets in the trial including Nahvintaas Molten Meteor.",
			default = true,
			getFunc = function() return sV.Enable.Comet end,
			setFunc = function(newValue)
				sV.Enable.Comet = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Shield Charge",
			tooltip = "Tracks the Shield Charge from the 1H & Shield add.",
			default = true,
			getFunc = function() return sV.Enable.Shield end,
			setFunc = function(newValue)
				sV.Enable.Shield = newValue
			end,
		},
		{
			type = "header",
			name = "Lokkestiiz Notifications",
		},
		{	type = "checkbox",
			name = "Enable Ice Tomb",
			tooltip = "Tracks the Ice Tombs spawn and remaining time to pick it up.",
			default = true,
			getFunc = function() return sV.Enable.IceTomb end,
			setFunc = function(newValue)
				sV.Enable.IceTomb = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Laser",
			tooltip = "Counts down the remaining time until Lokke´s beam attack.",
			default = true,
			getFunc = function() return sV.Enable.LaserLokke end,
			setFunc = function(newValue)
				sV.Enable.LaserLokke = newValue
			end,
		},
		{
			type = "header",
			name = "Yolnahkriin Notifications",
        },
		{	type = "checkbox",
			name = "Enable Fire Atro Spawn",
			tooltip = "Tracks the Fire Atro spawn.",
			default = true,
			getFunc = function() return sV.Enable.Atro end,
			setFunc = function(newValue)
				sV.Enable.Atro = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Lava Geyser",
			tooltip = "Will tell you when a Lava Geyser is about to hit near to you.\n|cff0000Note:|r Tracks this mechanic on all fights from Sunspire.",
			default = true,
			getFunc = function() return sV.Enable.Geyser end,
			setFunc = function(newValue)
				sV.Enable.Geyser = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Next Flare",
			tooltip = "Will show you a timer that tell you in how many time the next Flare will be casted.",
			default = true,
			getFunc = function() return sV.Enable.NextFlare end,
			setFunc = function(newValue)
				sV.Enable.NextFlare = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Cataclysm",
			tooltip = "Counts down the remaining time until Cataclysm ends.",
			default = true,
			getFunc = function() return sV.Enable.Cata end,
			setFunc = function(newValue)
				sV.Enable.Cata = newValue
			end,
		},
		{
			type = "header",
			name = "Nahviintaas Notifications",
		},
		{	type = "checkbox",
			name = "Enable Sweeping Breath",
			tooltip = "Notifies you about the Sweeping Breath and its direction.",
			default = true,
			getFunc = function() return sV.Enable.SweepBreath end,
			setFunc = function(newValue)
				sV.Enable.SweepBreath = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Thrash",
			tooltip = "Tracks Nahviin's Thrash that needs to be blocked or dogded.",
			default = true,
			getFunc = function() return sV.Enable.Thrash end,
			setFunc = function(newValue)
				sV.Enable.Thrash = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Fire Spit",
			tooltip = "Tracks the Fire Spit attack which summons an AoE and then an atronach.\n|cff0000Note:|r Also tracks this mechanic on Lokkestiiz.",
			default = true,
			getFunc = function() return sV.Enable.Spit end,
			setFunc = function(newValue)
				sV.Enable.Spit = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Next Meteor",
			tooltip = "Will show you a timer that tell you in how many time the next Meteor will be casted.",
			default = true,
			getFunc = function() return sV.Enable.NextMeteor end,
			setFunc = function(newValue)
				sV.Enable.NextMeteor = newValue
			end,
		},
		{	type = "submenu",
			name = "Advanced Meteor Mode",
			controls = {
				{	type = "checkbox",
					name = "Enable Advanced Meteor",
					tooltip = "Compared to the Comet / Meteor thing, it will tell you where to go with some arrows (right / left / back).",
					default = true,
					getFunc = function() return sV.Enable.AdvancedMeteor end,
					setFunc = function(newValue)
						sV.Enable.AdvancedMeteor = newValue
					end,
				},
				{	type = "editbox",
					name = "Statues Tank @Name",
					tooltip = "Enter the @ of the player who is going to tank the statues on last boss if there is one.",
					getFunc = function() return sV.nameStatuesTank end,
					setFunc = function(newValue) 
						sV.nameStatuesTank = newValue
						end,
				},
				{	type = "editbox",
					name = "Main Tank @Name",
					tooltip = "Enter the @ of the player who is going to main tank.",
					getFunc = function() return sV.nameMainTank end,
					setFunc = function(newValue) 
						sV.nameMainTank = newValue
						end,
				},
				{	type = "editbox",
					name = "Kite Healer @Name",
					tooltip = "Enter the @ of the player who is kiting and probably guarding the main tank.",
					getFunc = function() return sV.nameKiteHeal end,
					setFunc = function(newValue) 
						sV.nameKiteHeal = newValue
						end,
				},
			}
		},
		{	type = "description",
			text = " ",
		},
		{	type = "checkbox",
			name = "Enable Fire Storm",
			tooltip = "Tracks Nahvis arena-sized AoE.\n|cff0000Note:|r Will also notify you while in portal if you have LibMapPing and LibGPS enable, and someone using this addon upstair.",
			default = true,
			getFunc = function() return sV.Enable.Storm end,
			setFunc = function(newValue)
				sV.Enable.Storm = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Datas Sending",
			tooltip = "To enable or not the datas sending by map pings, so downstairs people can know when Fire Storm is coming.",
			default = false,
			getFunc = function() return sV.Enable.Sending end,
			setFunc = function(newValue)
				sV.Enable.Sending = newValue
			end,
			warning = "|cff0000Note:|r Only one person upstair sending datas is enough, so only one should enable this setting.\nMake sure to have someone enabling it tho.",
			disabled = function()
				if LibGPS2 and LibMapPing then
					return false --not disabled
				else
					return true --disabled
				end
			end,
		},
		{
			type = "header",
			name = "Downstair Notifications",
		},
		{	type = "checkbox",
			name = "Enable Wipe Countdown",
			tooltip = "Tracks the remaining time you have to kill the Eternal Servant.",
			default = true,
			getFunc = function() return sV.Enable.Wipe end,
			setFunc = function(newValue)
				sV.Enable.Wipe = newValue
			end,
		},
		{	type = "slider",
            name = "Time Remaining to Show",
            tooltip = "Only starts counting down if set to a lower than that.",
            getFunc = function() return sV.wipeCallLater end,
			setFunc = function(newValue)
				sV.wipeCallLater = newValue
			end,
            min = 10,
            max = 90,
            step = 1,
            default = 90,
            width = "full",
		},
		{	type = "description",
			text = "\nAll mechanics involving the portal during Nahviintaas bossfight.",
		},
		{	type = "checkbox",
			name = "Enable Portal",
			tooltip = "Tracks the Portal spawn aswell as the remaining time until it expires.",
			default = true,
			getFunc = function() return sV.Enable.Portal end,
			setFunc = function(newValue)
				sV.Enable.Portal = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Interrupt Down",
			tooltip = "Tracks the remaining time to Interupt the Eternal Servant.",
			default = true,
			getFunc = function() return sV.Enable.Interrupt end,
			setFunc = function(newValue)
				sV.Enable.Interrupt = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Pins Tracking",
			tooltip = "Counts down the remaining time until the next Pins.",
			default = true,
			getFunc = function() return sV.Enable.Pins end,
			setFunc = function(newValue)
				sV.Enable.Pins = newValue
			end,
		},
		{	type = "checkbox",
			name = "Enable Negate Field",
			tooltip = "Show a notification when you are targeted by the Negate Field while downstair.",
			default = true,
			getFunc = function() return sV.Enable.Negate end,
			setFunc = function(newValue)
				sV.Enable.Negate = newValue
			end,
		},
	}

	LAM2:RegisterOptionControls("HowToSunspire_Settings", optionsData)
end