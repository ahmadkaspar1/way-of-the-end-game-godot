extends CharacterBody2D

# تعريف المتغيرات في بداية الكود
@export var JUMP_VELOCITY = -500  # تصدير المتغير إلى المحرر
@export var GRAVITY = 10  # الجاذبية
@export var x = 300  # سرعة الحركة الأفقية

# المتغيرات التي لا تحتاج إلى تصديرها
var motion = Vector2()  # متغير للحركة
var can_double_jump = false  # متغير للتحقق من إمكانية القفز المزدوج

# دالة _physics_process
func _physics_process(delta):
	# تطبيق الجاذبية
	motion.y += GRAVITY

	# الحركة الأفقية
	if Input.is_action_pressed("ui_right"):
		motion.x = x
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -x
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
	elif Input.is_action_pressed("ui_down"):
		motion.y = 600  # هذا يمكن أن يؤثر على القفز، يجب تجنب تغيير motion.y هنا.
	else:
		motion.x = 0
		$AnimatedSprite2D.play("stand")

	# القفز الأول عند وجود الشخصية على الأرض
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_VELOCITY  # القفز الأول
			can_double_jump = true  # السماح بالقفز المزدوج

	# القفز المزدوج في الهواء
	else:
		if motion.y < 0:
			$AnimatedSprite2D.play("ty") 
		else:
			$AnimatedSprite2D.play("fall")

	# تحديث السرعة
	velocity = motion
	move_and_slide()

# دالة _process للتحقق من السقوط

		


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_node.tscn")
	


func _on_resart_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")
