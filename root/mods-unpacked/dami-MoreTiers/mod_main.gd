extends Node



const MOD_DIR = "dami-MoreTiers/"
const LOG_NAME = "dami-MoreTiers"

var dir = ""
var ext_dir = ""

func _init(modLoader = ModLoader):
	ModLoaderUtils.log_info("Init", LOG_NAME)
	dir = modLoader.UNPACKED_DIR + MOD_DIR
	ext_dir = dir + "extensions/"
	
	# Add extensions
	modLoader.install_script_extension(ext_dir + "singletons/item_service.gd")
	modLoader.install_script_extension(ext_dir + "singletons/utils.gd")
