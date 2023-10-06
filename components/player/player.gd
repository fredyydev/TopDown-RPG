extends CharacterBody2D
class_name Player

const SPEED = 125
const SPRINT_MULTI = 2

#The export tag makes the variable show up in the editor
#so you can assign it manually to a reference of animation tree.
@export var animation_tree: AnimationTree

# Called every frame. 'delta' is the elapsed time since the previous frame.                                     
func _physics_process(delta):
	#Get the input from the keybinds we created in the project settings.
	#Remember, when a key is pressed, the value is 1, when not pressed, 
	#the value is 0.
	#get_axis() is basically the first value minus the second value.
	var input_x = Input.get_axis("move_left", "move_right")
	var input_y = Input.get_axis("move_up", "move_down")
	
	#the direction is a Vector2 ( 2 numbers, x and y)
	#normalized() will make the value consistent when moving diagonally.
	var move_dir = Vector2(input_x, input_y).normalized()
	
	#we set the velocity to direction * speed and call the move_and_slide() function
	#we also check if we are sprinting
	if Input.is_action_pressed("sprint"):
		velocity = move_dir * SPEED * SPRINT_MULTI
	else:
		velocity = move_dir * SPEED
	#could be "move_and_slide()" or "move_and_collide()"
	move_and_slide()
	#create our own function for organization and readability
	handle_animations(move_dir)

func handle_animations(mv):
	#set the animation parameters to the expression!!
	animation_tree.set("parameters/conditions/is_idle", (mv == Vector2.ZERO)) 
	#returns either true or false, depending on the result of the expression.
	animation_tree.set("parameters/conditions/is_moving", (mv != Vector2.ZERO)) 
	#Only update the blend postion when it's not zero.
	if mv != Vector2.ZERO:
		#set the blend positions to direction
		animation_tree.set("parameters/Idle/blend_position", mv)
		animation_tree.set("parameters/Walk/blend_position", mv)
