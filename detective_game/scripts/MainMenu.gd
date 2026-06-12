## MainMenu.gd
## Главное меню игры.
extends Control

@onready var btn_new_game:  Button   = $VBox/BtnNewGame
@onready var btn_continue:  Button   = $VBox/BtnContinue
@onready var btn_settings:  Button   = $VBox/BtnSettings
@onready var btn_quit:      Button   = $VBox/BtnQuit
@onready var settings_node: Settings = $Settings

func _ready() -> void:
	GameManager.change_state(GameManager.GameState.MAIN_MENU)
	get_tree().paused = false   # снять паузу если осталась

	btn_new_game.pressed.connect(_on_new_game)
	btn_continue.pressed.connect(_on_continue)
	btn_settings.pressed.connect(_on_settings)
	btn_quit.pressed.connect(_on_quit)

	# «Продолжить» доступна только при наличии сохранения
	btn_continue.disabled = not SaveManager.has_save()

	if settings_node:
		settings_node.visible = false


func _on_new_game() -> void:
	GameManager.start_new_game()


func _on_continue() -> void:
	GameManager.continue_game()


func _on_settings() -> void:
	if settings_node:
		settings_node.open()


func _on_quit() -> void:
	get_tree().quit()
