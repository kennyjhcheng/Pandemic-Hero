extends Node2D



var timer
var progress = 0

var lowx = 282.541
var yaxis =589.083
var highx = 794.262
var midLowx = 524
var midHighx = 607
var heldAtLow = 0
var heldAtHigh = 0
var heldAtGood = 0
var failed = false
var inputAllowed = true
var instructionLabelText = "Left Click to catch the mouse. It's harder than you think. \nAfter you catch it, hold down the mouse button and keep the slider within the green area to inject the vaccine."

func _ready():
	$Instruction.text = "Catch the mouse"
	$InstructionLabel.text = instructionLabelText
	$AnimationPlayer.play("PlayInstructionLabel")
	


func _physics_process(delta):
	
		
	if failed== false and inputAllowed:
		if $meterHand.position>=Vector2(midLowx, yaxis) and $meterHand.position<Vector2(midHighx, yaxis) :
			
			if $hand.gameStart == true:
				$Instruction.text = "Maintain this pressure"
				$hand.texture = load("res://Assets/RatScene/Just_Right_Hand.png")
				heldAtGood+=1
				heldAtLow=0
				heldAtHigh=0
			
		elif $meterHand.position>=Vector2(lowx, yaxis) and $meterHand.position<Vector2(midLowx, yaxis) :
			
			
			
			if $hand.gameStart == true:
				$Instruction.text = "Too loose"
				$hand.texture = load("res://Assets/RatScene/Loose_Hand.png")
				heldAtLow+=1
				heldAtGood=0
				heldAtHigh=0
			
		elif $meterHand.position>=Vector2(midHighx, yaxis) and $meterHand.position<Vector2(highx, yaxis) :
			
			if $hand.gameStart == true:
				$Instruction.text ="Too tight"
				$hand.texture = load("res://Assets/RatScene/Tight_Hand.png")
				heldAtHigh+=1
				heldAtGood=0
				heldAtLow=0
		
			
		else:
			$Instruction.text = "Hold the left button"
			
		
		if heldAtHigh>150: 
			
			showFailedPopUp("Opps you killed the mouse.")
			$Path/PathFollow2D/Sprite.texture = load("res://Assets/RatScene/Mice_0.png")
		if heldAtLow>300:
			showFailedPopUp("Oops, your mouse escaped!")
		if heldAtGood>300:
			inputAllowed=false
			$AnimationPlayer.play("InjectRat")
			yield($AnimationPlayer, "animation_finished")
			var fadeOut = load("res://Scenes/FadeOutAnimation.tscn")
			var fadeOutInstance = fadeOut.instance()
			fadeOutInstance.name = 'fade'
			self.add_child(fadeOutInstance)
			get_node('fade/CanvasLayer/Label').text = "\"Going through challenging things can teach you a lot, and they also make you appreciate the times that aren't so challenging\"\n- Carrie Fisher"
			$AnimationPlayer.play("QuickFade")
			yield($AnimationPlayer, "animation_finished")
			get_node('fade').get_node('AnimationPlayer').play('FadeToMessageDisappear')
			yield(get_node('fade').get_node('AnimationPlayer'), 'animation_finished')
			get_node('fade/CanvasLayer/Label').text = "Thank you for playing our game. We hope you enjoyed it.\n Please help us improve the game by filling out a short feedback survey."
			$AnimationPlayer.play("QuickFade")
			yield($AnimationPlayer, "animation_finished")
			get_node('fade').get_node('AnimationPlayer').play('FadeToMessageDisappear')
#			var fadeOutInstance2 = fadeOut.instance()
#			fadeOutInstance2.name = 'fade2'
#			self.add_child(fadeOutInstance2)
#			get_node('fade2/CanvasLayer/Label').text = "Thank you for playing our game. We hope you enjoyed it.\n Please help us improve the game by filling out a short feedback survey."
#			get_node('fade2/AnimationPlayer').play('FadeToMessage')
#			yield(get_node('fade2/AnimationPlayer'), 'animation_finished')
#			get_tree().change_scene("res://Scenes/End/FeedBackUpdated.tscn")



func moveHandToTheRight():
	if $meterHand.position<=Vector2(highx, yaxis) and inputAllowed:
		$meterHand.position = $meterHand.position + Vector2(3,0)



func lerpHandToZero():
	if $meterHand.position>Vector2(lowx, yaxis) and inputAllowed:
		$meterHand.position = $meterHand.position - Vector2(3,0)


func showFailedPopUp(text):
	var timer = Timer.new()
	timer.set_wait_time(1)
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	timer.queue_free()
	$FailedPopUp.popup()
	$FailedPopUp/Text.text = text
	$ColorRect.visible = true
	$hand.texture = null
	$Path/PathFollow2D/Sprite.texture=null
	failed = true


func _on_TextureButton_pressed():
	$FailedPopUp.hide()
	$ColorRect.visible = false
	get_tree().change_scene("res://Scenes/RatScene/RatScene.tscn")


### Animation Related Stuff ###
func bringInjectionCloseToMouse():
	$Instruction.visible = false
	$InjectionCompletion.text = "Time to inject the rat.."
	$Injection.visible = true
	$Injection.global_position.x =  $hand.global_position.x - 50
	$Injection.global_position.y =  $hand.global_position.y - 25
	
	
func InjectionProgressOne():
	$InjectionCompletion.visible = true
	$Instruction.visible = false
	$InjectionCompletion.text = "Giving vaccine to the rat..."
	
	

func InjectionProgressTwo():
	$InjectionCompletion.text = "Almost there..."

func InjectionProgressThree():
	$InjectionCompletion.text = "Vaccine successfully injected to your mouse."
	

