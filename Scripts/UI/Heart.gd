extends MarginContainer

func changeIcon(isEmpty:bool)->void:
	if isEmpty:
		%FullIcon.visible = false
	else:
		%FullIcon.visible = true
