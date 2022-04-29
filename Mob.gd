extends KinematicBody

# 초당 미터 단위의 몹의 최소 속도입니다.
export var min_speed = 10
# 초당 미터 단위의 몹의 최대 속도.
export var max_speed = 18

var velocity = Vector3.ZERO


func _physics_process(_delta):
	move_and_slide(velocity)


# Main 장면에서 이 함수를 호출할 것입니다.
func initialize(start_position, player_position):
	translation = start_position
	# 우리는 몹을 돌려 플레이어를 바라보도록 합니다.
	look_at(player_position, Vector3.UP)
	# 그리고 플레이어를 향해 정확하게 움직이지 않도록 무작위로 회전합니다. ( 2PI 한바퀴 )
	rotate_y(rand_range(-PI / 4, PI / 4))

	# 무작위 속도를 계산합니다.
	var random_speed = rand_range(min_speed, max_speed)
	# 속도를 나타내는 전진 속도를 계산합니다. Vector3.FORWARD : Vector3( 0, 0, -1 )
	# x : 좌우, y : 상하, z : 전후진
	velocity = Vector3.FORWARD * random_speed 
	# 그런 다음 몹의 Y 회전을 기반으로 벡터를 회전하여 보고 있는 방향으로 이동합니다.
	velocity = velocity.rotated(Vector3.UP, rotation.y)


func _on_VisibilityNotifier_screen_exited():
	queue_free()
