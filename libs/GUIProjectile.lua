local GUI_Projectile = {}
GUI_Projectile.GUI = {}
GUI_Projectile.buttonCount = 0
GUI_Projectile.loaded = false
GUI_Projectile.selection = 0
GUI_Projectile.time = 0
GUI_Projectile.hidden = false
function GUI_Projectile.addButton(name, func,args, xmin, xmax, ymin, ymax)
	--print("Added Button"..name )
	GUI_Projectile.GUI[GUI_Projectile.buttonCount +1] = {}
	GUI_Projectile.GUI[GUI_Projectile.buttonCount +1]["name"] = name
	GUI_Projectile.GUI[GUI_Projectile.buttonCount+1]["func"] = func
	GUI_Projectile.GUI[GUI_Projectile.buttonCount+1]["args"] = args
	GUI_Projectile.GUI[GUI_Projectile.buttonCount+1]["active"] = false
	GUI_Projectile.GUI[GUI_Projectile.buttonCount+1]["xmin"] = xmin
	GUI_Projectile.GUI[GUI_Projectile.buttonCount+1]["ymin"] = ymin * (GUI_Projectile.buttonCount + 0.01) +0.02
	GUI_Projectile.GUI[GUI_Projectile.buttonCount+1]["xmax"] = xmax 
	GUI_Projectile.GUI[GUI_Projectile.buttonCount+1]["ymax"] = ymax 
	GUI_Projectile.buttonCount = GUI_Projectile.buttonCount+1
end
function GUI_Projectile.unload()
end
function GUI_Projectile.init()

	GUI_Projectile.loaded = true
end
function GUI_Projectile.tick()
	if(not GUI_Projectile.hidden)then
		if( GUI_Projectile.time == 0) then
			GUI_Projectile.time = GAMEPLAY.GET_GAME_TIMER()
		end
		if((GAMEPLAY.GET_GAME_TIMER() - GUI_Projectile.time)> 100) then
			GUI_Projectile.updateSelection()
		end	
		GUI_Projectile.renderGUI()	
		if(not GUI_Projectile.loaded ) then
			GUI_Projectile.init()	 
		end
	end
end

function GUI_Projectile.updateSelection() 
	if(get_key_pressed(Keys.ArrowDown)) then
	AUDIO.PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_LIQUOR_STORE_SOUNDSET", true)
		if(GUI_Projectile.selection < GUI_Projectile.buttonCount -1  )then
			GUI_Projectile.selection = GUI_Projectile.selection +1
			GUI_Projectile.time = 0
		end
	elseif (get_key_pressed(Keys.ArrowUp)) then
	AUDIO.PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_LIQUOR_STORE_SOUNDSET", true)
		if(GUI_Projectile.selection > 0)then
			GUI_Projectile.selection = GUI_Projectile.selection -1
			GUI_Projectile.time = 0
		end
	elseif (get_key_pressed(Keys.Enter)) then
	
		if(type(GUI_Projectile.GUI[GUI_Projectile.selection +1]["func"]) == "function") then
			GUI_Projectile.GUI[GUI_Projectile.selection +1]["func"](GUI_Projectile.GUI[GUI_Projectile.selection +1]["args"])
		else
			print(type(GUI_Projectile.GUI[GUI_Projectile.selection]["func"]))
		end
		GUI_Projectile.time = 0
	end
	local iterator = 0
	for id, settings in ipairs(GUI_Projectile.GUI) do
		GUI_Projectile.GUI[id]["active"] = false
		if(iterator == GUI_Projectile.selection ) then
			GUI_Projectile.GUI[iterator +1]["active"] = true
		end
		iterator = iterator +1
	end
end

function GUI_Projectile.renderGUI()
	 GUI_Projectile.renderButtons()
end
function GUI_Projectile.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
	GRAPHICS.DRAW_RECT(xMin, yMin,xMax, yMax, color1, color2, color3, color4);
end

function GUI_Projectile.renderButtons()

	for id, settings in pairs(GUI_Projectile.GUI) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GRAPHICS.GET_SCREEN_RESOLUTION(0, 0)
		boxColor = {30,32,29,200}

		if(settings["active"]) then
			boxColor = {107,158,44,200}
		end
		UI.SET_TEXT_FONT(2)
		UI.SET_TEXT_SCALE(0.0, 0.5)
		UI.SET_TEXT_COLOUR(255, 255, 255, 255)
		UI.SET_TEXT_CENTRE(false)
		UI.SET_TEXT_DROPSHADOW(255, 255, 255, 255, 100)
		UI.SET_TEXT_EDGE(0, 0, 0, 0, 0)
		UI._SET_TEXT_ENTRY("STRING")
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		UI._DRAW_TEXT(settings["xmin"]+ 0.02, (settings["ymin"]  + 0.045 - 0.0125 ))
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		GUI_Projectile.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"] + 0.05, settings["ymax"] - 0.0,boxColor[1],boxColor[2],boxColor[3],boxColor[4])
	end   
	 
	UI.SET_TEXT_FONT(4)
 	UI.SET_TEXT_SCALE(0.0, 0.70)
 	UI.SET_TEXT_COLOUR(255, 255, 255, 255)
 	UI.SET_TEXT_CENTRE(false)
 	UI.SET_TEXT_DROPSHADOW(255, 255, 255, 255, 100)
 	UI.SET_TEXT_EDGE(0, 0, 0, 0, 0)
 	UI._SET_TEXT_ENTRY("STRING")
 	UI._ADD_TEXT_COMPONENT_STRING("PROJECTILE MENU")
 	UI._DRAW_TEXT(0.03, 0.004)
 	GUI_Projectile.renderBox(0.01,0.28,0.0,0.10 - 0.00,66,98,27,255)	
end
return GUI_Projectile