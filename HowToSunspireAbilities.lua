HowToSunspire = HowToSunspire or {}
local HowToSunspire = HowToSunspire

HowToSunspire.AbilitiesToTrack = {
    [120567] = HowToSunspire.HeavyAttack, --HA from statue on last boss
    [115723] = HowToSunspire.HeavyAttack, --HA from lokke
    [122124] = HowToSunspire.HeavyAttack, --HA from yolna
    [115443] = HowToSunspire.HeavyAttack, --HA from nahvin
    [121422] = HowToSunspire.HeavyAttack, --HA from cone downstair
    [117071] = HowToSunspire.HeavyAttack, --HA from 1H & Shield

    [117075] = HowToSunspire.ShieldCharge, --shield charge from 1H & Shield
    [116836] = HowToSunspire.Leap, --2H adds leap -- [116915] = HowToSunspire.Leap,[116916] = HowToSunspire.Leap, [116918] = HowToSunspire.Leap,
    --[[ TODO : Add tear and breathes
    [117526] = HowToSunspire.Tear, -- Soul tear
    [119283] = HowToSunspire.Frost, -- Frost Breath
    [121723] = HowToSunspire.Fire, -- Fire Breath
    [121980] = HowToSunspire.Searing, -- Searing Breath]]

    [120890] = HowToSunspire.Block, --jump from the red cats
    [122012] = HowToSunspire.Block, --jump from white cats

    [121075] = HowToSunspire.Comet, --comet from downstair (not on someone) 121074
    [120359] = HowToSunspire.Comet, --comet from lokkestiiz that bump
    [116636] = HowToSunspire.Comet, --comet from mage trash 116619
    [117251] = HowToSunspire.Comet, --molten meteor veteran
    [123067] = HowToSunspire.Comet, --molten meteor veteran

    [119632] = HowToSunspire.IceTomb, --ice tomb on first boss
    [122820] = HowToSunspire.LokkeLaser, --first jump of lokke
    [122821] = HowToSunspire.LokkeLaser, --second jump of lokke
    [122822] = HowToSunspire.LokkeLaser, --third jump of lokke

    [119549] = HowToSunspire.AtroSpawn, -- Fire Atro
    [124546] = HowToSunspire.LavaGeyser, --lava geyser from fire atro
    [121722] = HowToSunspire.NextFlare, --Focus fire casted
    [121459] = HowToSunspire.NextFlare, --boss go fly
    [122598] = HowToSunspire.Cata, -- Cataclysm

    [120188] = HowToSunspire.SweepingBreath, --fire sweeping breath >>>>
    [118743] = HowToSunspire.SweepingBreath, --fire sweeping breath <<<<
    [118860] = HowToSunspire.FireSpit, --when nahvin spit fire ball on you that will pop an atronach during lokke fight
    [115592] = HowToSunspire.FireSpit, --same but during nahvin fight
    [118562] = HowToSunspire.Thrash, -- thrash of nahvin
    [118884] = HowToSunspire.FireStorm, --room explosion of nahvin
    [117308] = HowToSunspire.NextMeteor, --entering phase 4
    [117938] = HowToSunspire.MarkForDeath, --cast debuff on tank

    [121676] = HowToSunspire.Portal, --Portal on last boss
    [121213] = HowToSunspire.IsDownstair, --Portal used
    [121254] = HowToSunspire.IsUpstair, --return to reality
    [121436] = HowToSunspire.InterruptDown, --attack to interrupt down
    [121411] = HowToSunspire.NegateField, --negate from downstair
}

--Add a notification :
    --add the ID here with a function
    --main file :
        --create the corresping function
        --create the UI function
        --add default values
        --add new events / variables to the reset function
    --settings file :
        --add to unlock all
        --add an enable / unlock option
        --add to the text size
    --UI file :
        --add to the init function
        --add the saveLoc function
    --XML file :
        --add th new part of UI