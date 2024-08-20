extends Node

signal enemy_died
signal player_died
signal damage
signal damage_taken(damage: int, health: int, previosHealth: int, source: Node, target: Node)
signal player_damage_taken(damage: int)
signal player_collision(other: Node)
signal zoom_change(exterior_to_interior: bool)
signal win_game
signal lose_game
signal change_mode(system: String)
