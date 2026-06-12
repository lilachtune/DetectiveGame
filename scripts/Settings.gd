## Settings.gd
## Панель настроек звука.
## Используется и в главном меню, и в паузе.
##
## Структура сцены:
##   Settings (Control)
##   └─ Panel (PanelContainer)
##       ├─ BtnClose (Button) — «×» в углу
##       └─ VBox (VBoxContainer)
##           ├─ Title (Label)
##           ├─ Row_Master (HBoxContainer)
##           │   ├─ Label "Общая громкость"
##           │   ├─ MasterSlider (HSlider) min=0 max=1 step=0.01
##           │   └─ MasterValue (Label)
##           ├─ Row_Music (HBoxContainer)
##           │   ├─ Label "Музыка"
##           │   ├─ MusicSlider  (HSlider)
##           │   └─ MusicValue   (Label)
##           └─ Row_SFX (HBoxContainer)
##               ├─ Label "Эффекты"
##               ├─ SFXSlider    (HSlider)
##               └─ SFXValue     (Label)
class_name Settings
extends Control

@onready var master_slider: HSlider = $Panel/VBox/Row_Master/MasterSlider
@onready var music_slider:  HSlider = $Panel/VBox/Row_Music/MusicSlider
@onready var sfx_slider:    HSlider = $Panel/VBox/Row_SFX/SFXSlider

@onready var master_value:  Label   = $Panel/VBox/Row_Master/MasterValue
@onready var music_value:   Label   = $Panel/VBox/Row_Music/MusicValue
@onready var sfx_value:     Label   = $Panel/VBox/Row_SFX/SFXValue

@onready var btn_close:     Button  = $Panel/BtnClose

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible      = false

	_sync_sliders_from_audio_manager()

	master_slider.value_changed.connect(_on_master_changed)
	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)

	btn_close.pressed.connect(_close)


func _close() -> void:
	visible = false


func _sync_sliders_from_audio_manager() -> void:
	master_slider.value = AudioManager.master_volume
	music_slider.value  = AudioManager.music_volume
	sfx_slider.value    = AudioManager.sfx_volume
	_update_labels()


# ─── Обработчики слайдеров ────────────────────────────────────────────────────

func _on_master_changed(value: float) -> void:
	AudioManager.set_master_volume(value)
	_update_labels()

func _on_music_changed(value: float) -> void:
	AudioManager.set_music_volume(value)
	_update_labels()

func _on_sfx_changed(value: float) -> void:
	AudioManager.set_sfx_volume(value)
	_update_labels()

func _update_labels() -> void:
	master_value.text = "%d%%" % roundi(AudioManager.master_volume * 100)
	music_value.text  = "%d%%" % roundi(AudioManager.music_volume  * 100)
	sfx_value.text    = "%d%%" % roundi(AudioManager.sfx_volume    * 100)
