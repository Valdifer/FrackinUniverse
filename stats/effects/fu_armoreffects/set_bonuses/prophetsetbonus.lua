require "/stats/effects/fu_armoreffects/setbonuses_common.lua"

setName="fu_prophetset"
setEffects={"glowyellow2"}

weaponBonus={
	{stat = "powerMultiplier", effectiveMultiplier = 1.25}
}

function init()
	setSEBonusInit(setName,setEffects)
	effectHandlerList.weaponBonusHandle=effect.addStatModifierGroup({})
	
	handleBonuses(0,checkSetWorn(self.setBonusCheck))
end

function update(dt)
	handleBonuses(dt,checkSetWorn(self.setBonusCheck))
end

function handleBonuses(dt,on)
	if on then
		effect.setStatModifierGroup(effectHandlerList.armorBonusHandle,armorBonus)
		applySetEffects()
		setRegen(0.006)
	else
		effect.setStatModifierGroup(effectHandlerList.armorBonusHandle,{})
		setRegen(0.0)
	end
	checkWeapons(not on)
end

function checkWeapons(autofail)
	if autofail then effect.setStatModifierGroup(effectHandlerList.weaponBonusHandle,{}) return end

	local weapons=weaponCheck({"staff","wand","quarterstaff"})
	if weapons["either"] then
		effect.setStatModifierGroup(effectHandlerList.weaponBonusHandle,weaponBonus)
	else
		effect.setStatModifierGroup(effectHandlerList.weaponBonusHandle,{})
	end
end