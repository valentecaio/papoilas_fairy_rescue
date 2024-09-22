extends Control

@onready var label_coins = $LabelCoins
@onready var label_fairies = $LabelFairies
@onready var label_kills = $LabelKills

func _process(_delta):
    label_coins.text = "COINS: " + str(Global.player_coins)
    label_fairies.text = "FAIRIES: " + str(Global.player_fairies)
    label_kills.text = "KILLS: " + str(Global.player_kills)
    
