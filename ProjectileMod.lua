--==============================================
--    Projectile Mod by Ideo

-- Bress B to open the menu
--==============================================

local ProjectileMod = {}

--==============================================
	local MaxMaxProjectile = 150 -- More than 200 can make the game instable
--==============================================

	local MinProjectile = 5
	local IncrementProjectile = 5
	local MaxProjectile = MaxMaxProjectile	
	local rate = 2
	local i = 0
	local P_Notif = {}
	local P_Notif_i = 1
	local EnableTurbulence = false
	local PForce = 5
	local P_ID = {}
	local BallModEnabled = false
	local b = 1
	local d = 1
	local PedHash = GAMEPLAY.GET_HASH_KEY("S_M_M_GARDENER_01")
	local PHash = GAMEPLAY.GET_HASH_KEY("prop_bowling_ball")
	local ModEnabled = false
	local PType = 1
	local KeyPressed = false
	local BallPool = {
	"prop_poolball_1",
	"prop_poolball_10",
	"prop_poolball_11",
	"prop_poolball_12",
	"prop_poolball_13",
	"prop_poolball_14",
	"prop_poolball_15",
	"prop_poolball_2",
	"prop_poolball_3",
	"prop_poolball_4",
	"prop_poolball_5",
	"prop_poolball_6",
	"prop_poolball_7",
	"prop_poolball_8",
	"prop_poolball_9",
	"prop_poolball_cue"}

function ProjectileMod.init()
	
	ProjectileMod.GUI_Projectile = Libs["GUIProjectile"] -- Main, Parent window
	--
	ProjectileMod.GUI_Projectile.addButton("START STOP MOD",ProjectileMod.Enable,nil,0,0.3,0.04,0.04)
	ProjectileMod.GUI_Projectile.addButton("Turbulence",ProjectileMod.Turbulence,nil,0,0.3,0.04,0.04)
	ProjectileMod.GUI_Projectile.addButton("Freeze",ProjectileMod.Freeze,nil,0,0.3,0.04,0.04)
	ProjectileMod.GUI_Projectile.addButton("Change projectile",ProjectileMod.ChangeType,nil,0,0.3,0.04,0.04)
	--ProjectileMod.GUI_Projectile.addButton("Ped projectile",ProjectileMod.ProPed,nil,0,0.3,0.04,0.04)
	ProjectileMod.GUI_Projectile.addButton("Power UP",ProjectileMod.PowerUP,nil,0,0.3,0.04,0.04)
	ProjectileMod.GUI_Projectile.addButton("Power DOWN",ProjectileMod.PowerDown,nil,0,0.3,0.04,0.04)
	ProjectileMod.GUI_Projectile.addButton("Fire Rate UP",ProjectileMod.RateUP,nil,0,0.3,0.04,0.04)
	ProjectileMod.GUI_Projectile.addButton("Fire Rate DOWN",ProjectileMod.RateDown,nil,0,0.3,0.04,0.04)
	ProjectileMod.GUI_Projectile.addButton("More Projectile",ProjectileMod.NumberUP,nil,0,0.3,0.04,0.04)
	ProjectileMod.GUI_Projectile.addButton("Less Projectile",ProjectileMod.NumberDown,nil,0,0.3,0.04,0.04)
	--
	ProjectileMod.GUI_Projectile.hidden =  true
	
end

function ProjectileMod.Enable()

	if(FreezeEnabled) then
		ProjectileMod.Freeze()
	end
		
	ModEnabled = not ModEnabled
	
	if (not BallModEnabled) then
		ProjectileMod.DrawText("Mod ~g~Enabled")
	else
		ProjectileMod.DrawText("Mod ~r~Disabled")

	end
	

end

function ProjectileMod.Flow()

	KeyPressed = not KeyPressed
	
	if (KeyPressed) then
		ProjectileMod.DrawText("Flow ~g~Enabled")
	else
		ProjectileMod.DrawText("Flow ~r~Disabled")

	end
	

end

function ProjectileMod.Turbulence()

	EnableTurbulence = not EnableTurbulence
	
	if (EnableTurbulence) then
		ProjectileMod.DrawText("Trubulence ~g~Enabled")
	else
		ProjectileMod.DrawText("Trubulence ~r~Disabled")
	end
	

end
function ProjectileMod.ChangeType()

	SpawnPedEnabled = false


	if (PType == MaxBallType) then
		PType = 1
	else
		PType = PType + 1
	end

	ProjectileMod.DrawText("Projectile ~g~" .. PType)

end

function ProjectileMod.NumberUP()
		ModEnabled = false
		deleteActive = false
			
		for k,v in ipairs(P_ID) do
			ENTITY.DELETE_ENTITY(P_ID[k])
		end	
		i = 1
		b = 1
	MaxProjectile = MaxProjectile + IncrementProjectile

	if(MaxProjectile >= MaxMaxProjectile) then
		MaxProjectile = MaxMaxProjectile
	end
	ProjectileMod.DrawText("Max projectile = ~b~" .. MaxProjectile)
	
end

function ProjectileMod.NumberDown()
		ModEnabled = false
		deleteActive = false
			
		for k,v in ipairs(P_ID) do
			ENTITY.DELETE_ENTITY(P_ID[k])
		end	
		i = 1
		b = 1
	MaxProjectile = MaxProjectile - IncrementProjectile

	if(MaxProjectile <= MinProjectile) then
		MaxProjectile = MinProjectile
	end

	ProjectileMod.DrawText("Max projectile = ~b~" .. MaxProjectile)
	
end

function ProjectileMod.RateUP()

	rate = rate - 1

	if(rate <= 1) then
		rate = 1
	end
	ProjectileMod.DrawText("Fire Rate = ~b~ 1/" .. rate .. " ticks")
	
end

function ProjectileMod.RateDown()

	rate = rate + 1

	if(rate >= 100) then
		rate = 100
	end

	ProjectileMod.DrawText("Fire Rate = ~b~ 1/" .. rate .. " ticks")
	
end

function ProjectileMod.PowerUP()

	PForce = PForce + 0.5

	if(PForce >= 10) then
		PForce = 10
	end

	ProjectileMod.DrawText("Force = ~b~" .. PForce)
	
end

function ProjectileMod.PowerDown()

	PForce = PForce - 0.5

	if(PForce <= 0.5) then
		PForce = 0.5
	end

	ProjectileMod.DrawText("Force = ~b~" .. PForce)
	
end

function ProjectileMod.ProPed()

		ModEnabled = false
		deleteActive = false
			
		for k,v in ipairs(P_ID) do
			ENTITY.DELETE_ENTITY(P_ID[k])
		end	
		i = 1
		b = 1

		SpawnPedEnabled = not SpawnPedEnabled
	
	if (SpawnPedEnabled) then
		ProjectileMod.DrawText("Ped ~g~Enabled")
		MaxProjectile = 10
		MaxMaxProjectile = 40
	else
		ProjectileMod.DrawText("Ped ~r~Disabled")
	end
	
end


function ProjectileMod.Freeze()

	FreezeEnabled = not FreezeEnabled
	
	if (BallModEnabled) then
		ProjectileMod.DrawText("Freeze ~g~Enabled")
	else
		ProjectileMod.DrawText("Freeze ~r~Disabled")
	end
	
	for k,v in ipairs(P_ID) do
		ENTITY.FREEZE_ENTITY_POSITION(P_ID[k], FreezeEnabled)
		ENTITY.APPLY_FORCE_TO_ENTITY(P_ID[k], 1, 0, 0, 0, 0, 0,0,0, true, false, true, true, true, true)
	end
	
	local pid = PLAYER.PLAYER_PED_ID()
	local VehList,CountVeh = PED.GET_PED_NEARBY_VEHICLES(pid, 1)
	local PedList,CountPed = PED.GET_PED_NEARBY_PEDS(pid, 1, -1)
	
	for k,v in ipairs(VehList) do
		ENTITY.FREEZE_ENTITY_POSITION(VehList[k], FreezeEnabled)
		ENTITY.APPLY_FORCE_TO_ENTITY(VehList[k], 1, 0, 0, 0,0,  0,0,0, true, false, true, true, true, true)
	end

	--for k,v in ipairs(PedList) do
	--	ENTITY.FREEZE_ENTITY_POSITION(PedList[k], FreezeEnabled)
	--	PED.SET_PED_CAN_PLAY_GESTURE_ANIMS(PedList[k], FreezeEnabled)
	--	ENTITY.APPLY_FORCE_TO_ENTITY(PedList[k], 1, 0, 0, 0, 0,0,0, true, false, true, true, true, true)
	--end
	
	BallModEnabled = not BallModEnabled
end

function ProjectileMod.DrawText(Text)
	for k,v in pairs(P_Notif) do 
		UI._REMOVE_NOTIFICATION(P_Notif[k])
	end
	
	UI._SET_NOTIFICATION_TEXT_ENTRY("STRING")
	UI._ADD_TEXT_COMPONENT_STRING(Text)
	P_Notif[P_Notif_i] = UI._DRAW_NOTIFICATION(false, true)
	P_Notif_i = P_Notif_i + 1
end


function ProjectileMod.tick()

	ProjectileMod.GUI_Projectile.tick()

	
-- MENU KEY ----------------------------------------------------------------------------------------------------------------
	if(get_key_pressed(Keys.F7))then
		
		ProjectileMod.GUI_Projectile.hidden =  not ProjectileMod.GUI_Projectile.hidden
		wait(500)
			
	end
----------------------------------------------------------------------------------------------------------------------------
		
-- Flow KEY ----------------------------------------------------------------------------------------------------------------
if(get_key_pressed(Keys.E))then
	
	ProjectileMod.Flow()
	wait(500)
		
end
----------------------------------------------------------------------------------------------------------------------------		
		

	if(ModEnabled)then
		ModEnabled = false
		deleteActive = false
			
		for k,v in ipairs(P_ID) do
			ENTITY.DELETE_ENTITY(P_ID[k])
		end	
		i = 1
		b = 1
		BallModEnabled = not BallModEnabled
		wait(1000)
			
	end
		

	if BallModEnabled then

		if (KeyPressed) then
		
			i = i + 1
			
			if(i >= rate) then
			i = 0
				if (b<MaxProjectile or deleteActive ) then
					
					if (not SpawnPedEnabled) then
						ProjectileMod.SpawnBall()
					else
						ProjectileMod.SpawnPed()
					end
					ProjectileMod.PForce(P_ID[b-1])	
					--wait(10)		
				else
					deleteActive = true
				end
					
				if (deleteActive) then
					ENTITY.DELETE_ENTITY(P_ID[b-MaxProjectile+1])
				end
				
			end
		end	
	end
end

function ProjectileMod.PForce(entity)


	local pid = PLAYER.PLAYER_PED_ID()
	local location = ENTITY.GET_ENTITY_COORDS(pid, nil)
	local heading = ENTITY.GET_ENTITY_HEADING(pid)
	local CamRot = CAM.GET_GAMEPLAY_CAM_ROT(2)
	
	CamRot.x = ((CamRot.x + 90) * 0.08) - 2
	CamRot.x = CamRot.x * CamRot.x

	local Fx = -( math.sin(math.rad(CamRot.z)) * CamRot.x )
	local Fy = ( math.cos(math.rad(CamRot.z)) * CamRot.x )
	local Fz = location.z
	
	local turbulenceX = 0
	local turbulenceY = 0
	local turbulenceZ = 0
	
	if (EnableTurbulence) then
		turbulenceX = math.random(-PForce*5,PForce*5)
		turbulenceY = math.random(-PForce*5,PForce*5)
		turbulenceZ = math.random(-1,1)
	end
	ENTITY.APPLY_FORCE_TO_ENTITY(entity, 1, PForce * Fx + turbulenceX, PForce * Fy + turbulenceY,  PForce * (CamRot.x - 20) + turbulenceZ, 0,0,0, 0, true, false, true, true, true, true)

	end
	
function ProjectileMod.SpawnBall()
	MaxBallType = 9
	local pid = PLAYER.PLAYER_PED_ID()
	local location = ENTITY.GET_ENTITY_COORDS(pid, nil)
	local heading = ENTITY.GET_ENTITY_HEADING(pid)

	local CamRot = CAM.GET_GAMEPLAY_CAM_ROT(2)
	local CamCoord = CAM.GET_GAMEPLAY_CAM_COORD()
	
	if (PType == 2) then
		PHash = GAMEPLAY.GET_HASH_KEY("prop_bskball_01")
	elseif (PType == 3) then
		PHash = GAMEPLAY.GET_HASH_KEY("prop_weight_20k")	
	elseif (PType == 4) then
		PHash = GAMEPLAY.GET_HASH_KEY("prop_wheel_tyre")	
	elseif (PType == 5) then
		PHash = GAMEPLAY.GET_HASH_KEY("prop_barbell_100kg")
	elseif (PType == 6) then
		PHash = GAMEPLAY.GET_HASH_KEY("prop_barrel_01a")
	elseif (PType == 7) then
		PHash = 1270590574 -- gas tank
	elseif (PType == 8) then
		PHash = 3231094434 -- brik
	elseif (PType == 9) then
		PHash = 600967813 -- poubelle
	else 	
		PHash = GAMEPLAY.GET_HASH_KEY("prop_bowling_ball")	
	end		
		
	local distance = 2
	
	local SpawnPosition = location
	SpawnPosition.x = location.x - ( math.sin(math.rad(CamRot.z)) * distance )
	SpawnPosition.y = location.y + ( math.cos(math.rad(CamRot.z)) * distance )
	SpawnPosition.z = location.z - 1
	
	
	local modelToSpawn = PHash

	

		STREAMING.REQUEST_MODEL(modelToSpawn)
		while (not STREAMING.HAS_MODEL_LOADED(modelToSpawn)) do wait(1) end
		P_ID[b] = OBJECT.CREATE_OBJECT(modelToSpawn, SpawnPosition.x, SpawnPosition.y, SpawnPosition.z, true, false, true)
		--OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(P_ID[b])			
		ENTITY.SET_ENTITY_HEADING(P_ID[b], CamRot.z)
		NETWORK.SET_ENTITY_LOCALLY_INVISIBLE(P_ID[b])
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(modelToSpawn)
		
	if (PType == 2) then
		ENTITY.SET_ENTITY_ROTATION(P_ID[b], 90 , CamRot.z, 0, 2, true)
	elseif (PType == 3) then
		ENTITY.SET_ENTITY_ROTATION(P_ID[b], 90, CamRot.z, 0, 2, true)	
	elseif (PType == 4) then
		ENTITY.SET_ENTITY_ROTATION(P_ID[b],0 , 90, CamRot.z + 90, 2, true)	
	elseif (PType == 5) then
	elseif (PType == 6) then
		ENTITY.SET_ENTITY_ROTATION(P_ID[b], 90, 90, CamRot.z, 2, true)
	elseif (PType == 7) then
	else 	
		ENTITY.SET_ENTITY_ROTATION(P_ID[b], 90, CamRot.z, 0, 2, true)
	end	
		
		b = b + 1
end

function ProjectileMod.SpawnPed()	

	local pid = PLAYER.PLAYER_PED_ID()
	local location = ENTITY.GET_ENTITY_COORDS(pid, nil)
	local heading = ENTITY.GET_ENTITY_HEADING(pid)

	local CamRot = CAM.GET_GAMEPLAY_CAM_ROT(2)
	local CamCoord = CAM.GET_GAMEPLAY_CAM_COORD()
		

	local distance = 2
	
	local SpawnPosition = location
	SpawnPosition.x = location.x - ( math.sin(math.rad(CamRot.z)) * distance )
	SpawnPosition.y = location.y + ( math.cos(math.rad(CamRot.z)) * distance )
	SpawnPosition.z = location.z - 1
	
	local Time = 100
	local delay = Time * 100

	local modelToSpawn = PedHash

	P_ID[b] = PED.CLONE_PED(pid, CamRot.z, true, true)
	ENTITY.SET_ENTITY_COORDS(P_ID[b], SpawnPosition.x, SpawnPosition.y, SpawnPosition.z, false, false, false, true)

		b = b + 1
end	

return ProjectileMod