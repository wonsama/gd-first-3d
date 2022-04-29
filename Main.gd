extends Node

export (PackedScene) var mob_scene

func _ready():
	randomize()


func _on_Timer_timeout():
	# Mob 인스턴스를 만들고 장면에 추가합니다.
	var mob = mob_scene.instance()

	# Path2D에서 임의의 위치를 선택합니다.
	# SpawnLocation 노드에 대한 참조를 저장합니다.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# 그리고 임의의 오프셋을 지정합니다.
	mob_spawn_location.unit_offset = randf()

	var player_position = $Player.transform.origin

	add_child(mob)
	mob.initialize(mob_spawn_location.translation, player_position)
