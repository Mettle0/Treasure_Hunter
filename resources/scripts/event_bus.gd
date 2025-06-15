extends Node


#===ITEM SIGNALS===
signal treasure_collected(itemID)
signal item_positions(pos: Array)

#===STAGE INTERACTABLE SIGNALS===
signal stage_buttonPressed(buttonID)

#===STAGE MANAGEMENT SIGNALS===
signal level_complete
signal switch_level(currentLevel, nextLevel)
