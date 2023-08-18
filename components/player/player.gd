extends CharacterBody2D
class_name Player

const SPEED = 125
var direction: Vector2 
#The export tag makes the variable show up in the editor
#so you can assign it manually to a reference of animation tree.
@export var animation_tree: AnimationTree

# Called every frame. 'delta' is the elapsed time since the previous frame.                                     
func _physics_process(delta):
	#Get the input from the keybinds we creared in the project settings.
	#Remeber, when a key is pressed, the value is 1, when not pressed, 
	#the value is 0.
	#get_axis() is basically the first value minus the second value.
	var input_x = Input.get_axis("move_left", "move_right")
	var input_y = Input.get_axis("move_up", "move_down")
	
	#the direction is a Vector2 ( 2 numbers, x and y)
	#normalized() will make the value consistent when moving diagonally.
	direction = Vector2(input_x, input_y).normalized()
	
	#we set the velocity to direction * speed and call the move() function
	#could be "move_and_slide()" or "move_and_collide()"
	velocity = direction * SPEED
	move_and_slide()
	#set the animation parameters to the expeession!!
	animation_tree["parameters/conditions/is_idle"] = (velocity == Vector2.ZERO)
	#returns either true or false, depending on the result of the expression.
	animation_tree["parameters/conditions/is_moving"] = (velocity != Vector2.ZERO)
	#Only update the blend postion when it's not zero.
	if direction != Vector2.ZERO:
		#set the blend positions to direction
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Walk/blend_position"] = direction
