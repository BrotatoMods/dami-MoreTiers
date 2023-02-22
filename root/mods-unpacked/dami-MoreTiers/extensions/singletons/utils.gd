extends "res://singletons/utils.gd"


# To avoid calling get_rand_element on an empty array
func get_rand_element(array:Array):
	if array.size() > 0:
		return .get_rand_element(array)
	else:
		return null
