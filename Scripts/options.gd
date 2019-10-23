extends Node

var config_file = "user://game.config"

var game_speed = 0.6
var player_approaching_speed = 5.0
var enemy_approaching_speed = 5.0
var attack_speed = 3.0

func default_config(file_name):
    return {
        game_speed = 0.4,
        player_approaching_speed = 5.0,
        enemy_approaching_speed = 5.0,
        attack_speed = 3.0
    }

func load_from_file():
    var config = utils.load_dict(config_file, self, 'default_config')
    game_speed = config.game_speed
    player_approaching_speed = config.player_approaching_speed
    enemy_approaching_speed = config.enemy_approaching_speed
    attack_speed = config.attack_speed

func save_to_file():
    utils.save_dict(config_file, {
        game_speed = game_speed,
        player_approaching_speed = player_approaching_speed,
        enemy_approaching_speed = enemy_approaching_speed,
        attack_speed = attack_speed
    })

func _init():
    load_from_file()
