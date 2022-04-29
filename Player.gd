extends KinematicBody

# 거리가 미터 단위이기 때문에 값은 2D 코드와 상당히 다릅니다. 
# 2D에서 천 단위(픽셀)는 화면 너비의 절반에만 해당할 수 있지만 3D에서는 킬로미터입니다.

# 플레이어가 초당 미터로 움직이는 속도.
export var speed = 14
# 공중에서 하향 가속도(미터/초 제곱)입니다.
export var fall_acceleration = 75

var velocity = Vector3.ZERO

# 여기서는 _physics_process() 가상 함수를 사용하여 모든 계산을 수행합니다. 
# _process() 와 같이 매 프레임마다 노드를 업데이트할 수 있지만 
# 운동학 또는 강체 이동과 같은 물리학 관련 코드를 위해 특별히 설계되었습니다.
func _physics_process(delta):
	# 입력 방향을 저장할 지역 변수를 만듭니다.
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x += -1
	# 벡터의 x 및 z 축으로 작업하는 방법에 주목하십시오.
	# 3D에서 XZ 평면은 접지 평면입니다.
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	
	# 플레이어가 W와 D를 동시에 누른 경우 벡터의 길이는 약 1.4. 그러나 단일 키를 누르면 길이가 1. 
	# 우리는 벡터의 길이가 일정하기를 원합니다. 그렇게 하기 위해 normalize()메서드를 호출할 수 있습니다.
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(translation + direction, Vector3.UP)

	# 지상 속도
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	# 수직 속도
	velocity.y -= fall_acceleration * delta
	# 캐릭터 이동
	velocity = move_and_slide(velocity, Vector3.UP)
