extends "res://singletons/item_service.gd"

const Tier4 = {
	"MIN_WAVE": 10, 
	"BASE_CHANCE": 0.0, 
	"WAVE_BONUS_CHANCE": 0.0014, 
	"MAX_CHANCE": 0.055
}

const Tier5 = {
	"MIN_WAVE": 16, 
	"BASE_CHANCE": 0.0, 
	"WAVE_BONUS_CHANCE": 0.0011, 
	"MAX_CHANCE": 0.04
}

const ALTERNATIVE_D4_COLOR = Color(255.0 / 255, 119.0 / 255, 10.0 / 255, 1)
const ALTERNATIVE_D4_COLOR_DARK = Color(50.0 / 255, 9.0 / 255, 0.0 / 255, 1)


func reset_tiers_data()->void :
	.reset_tiers_data()
	
	_tiers_data.push_back(
		[
			[], [], [], [], [],
			Tier4.MIN_WAVE,
			Tier4.BASE_CHANCE,
			Tier4.WAVE_BONUS_CHANCE,
			Tier4.MAX_CHANCE
		]
	)
	_tiers_data.push_back(
		[
			[], [], [], [], [],
			Tier5.MIN_WAVE,
			Tier5.BASE_CHANCE,
			Tier5.WAVE_BONUS_CHANCE,
			Tier5.MAX_CHANCE
		]
	)


func init_unlocked_pool()->void :
	.init_unlocked_pool()
	
	## Add Tier 5 upgrades to Legendary weapons
	for weapon in weapons:
		if weapon.upgrades_into == null and weapon.tier == Tier.LEGENDARY:
			for same_weapon in weapons:
				if same_weapon.weapon_id == weapon.weapon_id and same_weapon.tier == weapon.tier + 1:
					weapon.upgrades_into = same_weapon
					break

	# Remove useless arrays
	if not has_content_from_tier(Tier.DANGER_4):
		_tiers_data.pop_back()
		_tiers_data.pop_back()
		
	elif not has_content_from_tier(Tier.DANGER_5):
		_tiers_data.pop_back()
		


func has_content_from_tier(tier:int)->bool:
	return (
		get_pool(tier, TierData.WEAPONS).size() > 0 or
		get_pool(tier, TierData.UPGRADES).size() > 0 or
		get_pool(tier, TierData.ITEMS).size() > 0
	)

# Avoids null points in case the given type has no content of this tier
func get_rand_item_from_wave(wave:int, type:int, shop_items:Array = [], prev_shop_items:Array = [], fixed_tier:int = - 1)->ItemParentData:
	var vanilla_item = .get_rand_item_from_wave(wave, type, shop_items, prev_shop_items, fixed_tier)
	
	if not vanilla_item:
		var item_tier = find_highest_tier_for_type(type)
		vanilla_item = Utils.get_rand_element(_tiers_data[item_tier][type])
		 
	return vanilla_item


func find_highest_tier_for_type(type:int)->int:
	var highest_tier = 0
	for i in _tiers_data.size():
		if _tiers_data[i][type].size() > 0:
			highest_tier = i
		else:
			break
	
	return highest_tier

func get_color_from_tier(tier:int, dark_version:bool = false)->Color:
	if tier == Tier.DANGER_4:
		return ALTERNATIVE_D4_COLOR_DARK if dark_version else ALTERNATIVE_D4_COLOR
	else:
		return .get_color_from_tier(tier, dark_version)



