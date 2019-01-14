size = { 450, 450 }
xcam=0
ycam=0
zcam=0
lamp1 = sasl.loadObject("lamp\\lamp.obj")
lampDatarefs={"PNV/light/lampdataref1"}
--lampInstance = sasl.createInstance(lamp1 , lampDatarefs)
camheading=globalPropertyf ( "sim/graphics/view/view_heading", false )
defineProperty("background_img",  sasl.gl.loadImage("pic/main.png"))
defineProperty("button",  sasl.gl.loadImage("pic/blue.png"))
defineProperty("buttongr",  sasl.gl.loadImage("pic/gray.png"))
defineProperty("buttonsq",  sasl.gl.loadImage("pic/blue_sq.png"))
MainFont = sasl.gl.loadFont ( "fonts/DejaVuSans.ttf" )
MainFont2 = sasl.gl.loadFont ( "fonts/DejaVuSans-Bold.ttf" )
instanceID=0
local pressed_button={0,0} --param, custom
local paramdatapressed = {0,0,0,0,0,0,0,0,0}
local blinker=-0.5
local osName = sasl.getOS()
function add_light()
	lampInstance = sasl.createInstance(lamp1 , lampDatarefs)
	xcam,ycam,zcam,pitchcam,yawcam,rollcam,zoomcam=sasl.getCamera()
	--xxcam,yycam,zzcam=sasl.worldToLocal(xcam,zcam,ycam)
	xcam=xcam--+4*math.sin(math.rad(get(camheading)))
	zcam=zcam---4*math.cos(math.rad(get(camheading)))
	sasl.setInstancePosition(lampInstance , xcam,ycam,zcam, 0 , 0 , 0 , {1})
	xxxcam,yyycam,zzzcam,qpitchcam,qyawcam,qrollcam,qzoomcam=sasl.getCamera()
	if (sasl.getCurrentCameraStatus ()~= CAMERA_CONTROLLED_ALWAYS) then
		sasl.startCameraControl(cameraControllerID ,CAMERA_CONTROLLED_UNTIL_VIEW_CHANGE)
	end
	return lampInstance,xxxcam,yyycam,zzzcam,yawcam
end
function update_pos()
	
	xcam,ycam,zcam,pitchcam,yawcam,rollcam,zoomcam=sasl.getCamera()
	--xxcam,yycam,zzcam=sasl.worldToLocal(xcam,zcam,ycam)
	xcam=xcam--+math.sin(math.rad(get(camheading)))
	zcam=zcam---math.cos(math.rad(get(camheading)))
	sasl.setInstancePosition(instanceID , xcam,ycam,zcam, 0 , 0 , 0 , {1})
	
end
function update_h()
	
	xxcam,yycam,zzcam,pitchcam,yawcam,rollcam,zoomcam=sasl.getCamera()
	--xxcam,yycam,zzcam=sasl.worldToLocal(xcam,zcam,ycam)
	--xcam=xcam--+math.sin(math.rad(get(camheading)))
	ycam=yycam---math.cos(math.rad(get(camheading)))
	--zcam=zcam---math.cos(math.rad(get(camheading)))
	sasl.setInstancePosition(instanceID , xcam,ycam,zcam, 0 , 0 , 0 , {1})
	
end
function showhideball()
	if get(PNVLightConfig,2)==1 then
		set(PNVLightConfig,0,2)
	else
		set(PNVLightConfig,1,2)
	end
end
function move_pos(degree,coeff,height)
	
	if height==0 then
	--	xcam=xcam+x*math.sin(math.rad(get(camheading)))
	--else
		xcam=xcam-coeff*math.sin(math.rad(get(camheading)+degree))
		zcam=zcam+coeff*math.cos(math.rad(get(camheading)+degree))
	
	end
	ycam=ycam+height
	--if z~=0 then
	--	zcam=zcam-z*math.cos(math.rad(get(camheading)))
	--else
		
	--end
	sasl.setInstancePosition(instanceID , xcam,ycam,zcam, 0 , 0 , 0 , {1})
	xxxcam=xcam
	yyycam=ycam
	zzzcam=zcam
end
function hidelight()
	sasl.destroyInstance (instanceID)
	instanceID=0
	if (sasl.getCurrentCameraStatus ()~= CAMERA_CONTROLLED_ALWAYS) then
		sasl.stopCameraControl ()
	end
end
function onModuleDone()
	if (sasl.getCurrentCameraStatus ()~= CAMERA_CONTROLLED_ALWAYS) then
		sasl.stopCameraControl ()
	end
	if instanceID~=0 then sasl.destroyInstance (instanceID) end
	--sasl.unregisterCameraController(newCameraController)
end
function newCameraController()
	
	--print(xxxcam)
	sasl.setCamera(xxxcam, yyycam+10, zzzcam,   -90 , yawcam ,  0 ,   1	)
end
cameraControllerID = sasl.registerCameraController(newCameraController)
status = sasl.getCurrentCameraStatus ()
--print(status)
function changecamstate()
	if (sasl.getCurrentCameraStatus ()== CAMERA_CONTROLLED_UNTIL_VIEW_CHANGE) then
		sasl.stopCameraControl ()
	elseif (sasl.getCurrentCameraStatus ()== CAMERA_NOT_CONTROLLED) then
		sasl.startCameraControl(cameraControllerID ,CAMERA_CONTROLLED_UNTIL_VIEW_CHANGE)
	end
end



sizetext=20
sizetext2=16
lengthtext = 0
sizetextset=false
page_cloud=1
mnm=""
timercount=0
local calcangle = 0
local calcdirection = 0
StartTimerID = sasl.createTimer ()
sasl.startTimer(StartTimerID)
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
local paramdata = {tostring(round(get(Light1,1),2)),tostring(round(get(Light1,2),2)),tostring(round(get(Light1,3),2)),tostring(round(get(Light1,4),1)),tostring(round(get(Light1,5),1)),tostring(round(get(Light1,6),3)),tostring(round(get(Light1,7),3)),tostring(round(get(Light1,8),3)),tostring(round(get(Light1,9),3))}
function setparamdata()
	paramdata = {tostring(round(get(Light1,1),2)),tostring(round(get(Light1,2),2)),tostring(round(get(Light1,3),2)),tostring(round(get(Light1,4),1)),tostring(round(get(Light1,5),1)),tostring(round(get(Light1,6),3)),tostring(round(get(Light1,7),3)),tostring(round(get(Light1,8),3)),tostring(round(get(Light1,9),3))}
end

function normalizedvector()
 local abra=-((get(LightAuto,3)/math.tan(math.rad(get(LightAuto,1))))*math.sin(math.rad(get(LightAuto,2))))/math.sqrt(get(LightAuto,3)^2+((get(LightAuto,3)/math.tan(math.rad(get(LightAuto,1))))*math.cos(math.rad(get(LightAuto,2))))^2+((get(LightAuto,3)/math.tan(math.rad(get(LightAuto,1))))*math.sin(math.rad(180-get(LightAuto,2))))^2)
 local babra = (get(LightAuto,3)/math.sqrt(get(LightAuto,3)^2+((get(LightAuto,3)/math.tan(math.rad(get(LightAuto,1))))*math.cos(math.rad(180-get(LightAuto,2))))^2+((get(LightAuto,3)/math.tan(math.rad(get(LightAuto,1))))*math.sin(math.rad(180-get(LightAuto,2))))^2))*(get(LightAuto,1)/math.sqrt(get(LightAuto,1)^2))
 local cabra=-((get(LightAuto,3)/math.tan(math.rad(get(LightAuto,1))))*math.cos(math.rad(180-get(LightAuto,2))))/math.sqrt(get(LightAuto,3)^2+((get(LightAuto,3)/math.tan(math.rad(get(LightAuto,1))))*math.cos(math.rad(180-get(LightAuto,2))))^2+((get(LightAuto,3)/math.tan(math.rad(get(LightAuto,1))))*math.sin(math.rad(180-get(LightAuto,2))))^2)
 --print(round(abra,3))
-- print(round(babra,3))
 --print(round(cabra,3))
 set(Light1,round(abra,2),7)
 set(Light1,round(babra,2),8)
 set(Light1,round(cabra,2),9)
end

function normilezedvectorpro(changed,XX)
	if XX==1 then
		xy=get(Light1,8)/math.sqrt(changed^2+get(Light1,8)^2+get(Light1,9)^2)
		xz=get(Light1,9)/math.sqrt(changed^2+get(Light1,8)^2+get(Light1,9)^2)
		set(Light1,round(xy,3),8)
		set(Light1,round(xz,3),9)
	elseif XX==2 then
		xy=get(Light1,7)/math.sqrt(changed^2+get(Light1,7)^2+get(Light1,9)^2)
		xz=get(Light1,9)/math.sqrt(changed^2+get(Light1,7)^2+get(Light1,9)^2)
		set(Light1,round(xy,3),7)
		set(Light1,round(xz,3),9)
	elseif XX==3 then
		xy=get(Light1,7)/math.sqrt(changed^2+get(Light1,8)^2+get(Light1,7)^2)
		xz=get(Light1,8)/math.sqrt(changed^2+get(Light1,8)^2+get(Light1,7)^2)
		set(Light1,round(xy,3),7)
		set(Light1,round(xz,3),8)
	end
end
function setcopytext(XX)
	paramlight= "LIGHT_PARAM full_custom_halo 0.000000 0.000000 0.000000 "..round(get(Light1,1),2).." "..round(get(Light1,2),2).." "..round(get(Light1,3),2).." "..round(get(Light1,4),2).." "..round(get(Light1,5),2).." "..round(get(Light1,7),3).." "..round(get(Light1,8),3).." "..round(get(Light1,9),3).." "..round(get(Light1,6),2)
	spilllight= "LIGHT_SPILL_CUSTOM 0.000000 0.000000 0.000000 "..round(get(Light1,1),2).." "..round(get(Light1,2),2).." "..round(get(Light1,3),2).." "..round(get(Light1,4),2).." "..round(get(Light1,5),2).." "..round(get(Light1,6),2).." "..round(get(Light1,7),3).." "..round(get(Light1,8),3).." "..round(get(Light1,9),3).." none #(or dataref)"
	if XX==1 then
			if osName == "Linux" then
			
			else
				sasl.setClipboardText (spilllight)
			end
	elseif XX==2 then
		if osName == "Linux" then
			
		else
			sasl.setClipboardText (paramlight)
		end
	end
	lightfilepath = moduleDirectory.."/customlights.txt"
	lightfile = io.open(lightfilepath, "w")
	lightfile:write(paramlight, "\n")
	lightfile:write(spilllight, "\n")
	lightfile:close()
end

function update()
	--normalvector=(get(Light1,7)*get(Light1,7))+(get(Light1,8)*get(Light1,8))+(get(Light1,9)*get(Light1,9))
	for i=1,9,1 do
		if paramdatapressed[i]==1 then
			blinker=blinker+0.05
			if blinker>1 then
				blinker=-0.5
			end
		end
	end
end
function draw()
	sasl.gl.drawTexture(get(background_img) , 0 , 0 , 450 , 450, {1 , 1 , 1 , 1 })
	sasl.gl.drawRectangle (0,0,450,450,{1,1,1,0.1})
	sasl.gl.drawTexture(get(button) , 10 , 20 , 110 , 35, {1 , 1 , 1 , 1 })
	if get(PNVLightConfig,1)==0 then
		sasl.gl.drawText ( MainFont2 , 65 , 32 , "Show helper" , 14 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
	else
		if (sasl.getCurrentCameraStatus ()~= CAMERA_CONTROLLED_UNTIL_VIEW_CHANGE) then
			sasl.gl.drawTexture(get(buttongr) , 260 , 230 , 110 , 35, {1 , 1 , 1 , 1 })
			sasl.gl.drawText ( MainFont2 , 317 , 242 , "Control cam" , 12 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		else
			sasl.gl.drawTexture(get(button) , 260 , 230 , 110 , 35, {1 , 1 , 1 , 1 })
			sasl.gl.drawText ( MainFont2 , 317 , 242 , "Release cam" , 12 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		end
		if pressed_button[1]==0 then 
			sasl.gl.drawTexture(get(buttongr) , 260 , 280 , 110 , 35, {1 , 1 , 1 , 1 })
		else
			sasl.gl.drawTexture(get(button) , 260 , 280 , 110 , 35, {1 , 1 , 1 , 1 })
		end
		if pressed_button[2]==0 then 
			sasl.gl.drawTexture(get(buttongr) , 260 , 320 , 110 , 35, {1 , 1 , 1 , 1 })
		else
			sasl.gl.drawTexture(get(button) , 260 , 320 , 110 , 35, {1 , 1 , 1 , 1 })
		end
		sasl.gl.drawText ( MainFont2 , 317 , 292 , "CUSTOM SPILL" , 12 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 317 , 332 , "PARAM Light" , 12 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		sasl.gl.drawTexture(get(button) , 260 , 190 , 110 , 35, {1 , 1 , 1 , 1 })
		sasl.gl.drawTexture(get(button) , 260 , 150 , 110 , 35, {1 , 1 , 1 , 1 })
		sasl.gl.drawTexture(get(button) , 260 , 110 , 110 , 35, {1 , 1 , 1 , 1 })
		sasl.gl.drawTexture(get(buttonsq) , 260 , 20 , 35 , 35, {1 , 1 , 1 , 1 })
		sasl.gl.drawTexture(get(buttonsq) , 300 , 20 , 35 , 35, {1 , 1 , 1 , 1 })
		sasl.gl.drawTexture(get(buttonsq) , 300 , 60 , 35 , 35, {1 , 1 , 1 , 1 })
		sasl.gl.drawTexture(get(buttonsq) , 340 , 20 , 35 , 35, {1 , 1 , 1 , 1 })
		--sasl.gl.drawTexture(get(buttonsq) , 390 , 60 , 35 , 35, {1 , 1 , 1 , 1 })
		sasl.gl.drawTexture(get(buttonsq) , 390 , 20 , 35 , 35, {1 , 1 , 1 , 1 })
		sasl.gl.drawTexture(get(button) , 130 , 20 , 110 , 35, {1 , 1 , 1 , 1 })
		if get(PNVLightConfig,3)==0 then
			sasl.gl.drawText ( MainFont2 , 185 , 32 , "Auto mode" , 13 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		elseif get(PNVLightConfig,3)==1 then
			sasl.gl.drawText ( MainFont2 , 185 , 32 , "Manual mode" , 13 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		elseif get(PNVLightConfig,3)==2 then
			sasl.gl.drawText ( MainFont2 , 185 , 32 , "Pro mode" , 13 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		end
		sasl.gl.drawText ( MainFont2 , 65 , 32 , "Hide helper" , 14 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		if get(PNVLightConfig,2)==1 then
			sasl.gl.drawText ( MainFont2 , 317 , 202 , "Hide ball" , 14 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		else
			sasl.gl.drawText ( MainFont2 , 317 , 202 , "Show ball" , 14 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		end
		sasl.gl.drawText ( MainFont2 , 317 , 162 , "Update pos" , 14 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 317 , 122 , "Update H" , 14 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 317 , 72 , "Fwd" , 11 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 317 , 32 , "Back" , 11 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 277 , 32 , "<-" , 14 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 357 , 32 , "->" , 14 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		--sasl.gl.drawText ( MainFont2 , 407 , 72 , "Up" , 11 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 407 , 32 , "H" , 14 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
	end
	sasl.gl.drawText ( MainFont2 , 225 , 420 , "3D Light Config" , sizetext , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
	sasl.gl.drawWideLine (0,410,450,410,3,{1,1,1,1})
	sasl.gl.drawRectangle (10,60,230,320,{0,0,0,0.7})
	sasl.gl.drawText ( MainFont2 , 225 , 390 , "Change params with mouse wheel or keyboard" , 14 , false , false , TEXT_ALIGN_CENTER , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 20 , 350 , "R" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 120 , 350 , paramdata[1] , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 20 , 320 , "G" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 120 , 320 , paramdata[2] , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 20 , 290 , "B" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 120 , 290 , paramdata[3] , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 20 , 260 , "Alfa" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 120 , 260 , paramdata[4] , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 20 , 230 , "SIZE" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 120 , 230 , paramdata[5] , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 20 , 200 , "Cone" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	sasl.gl.drawText ( MainFont2 , 120 , 200 , paramdata[6] , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	if get(PNVLightConfig,3)>0 then
		sasl.gl.drawText ( MainFont2 , 20 , 170 , "XX" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 120 , 170 , paramdata[7] , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 20 , 140 , "YY" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 120 , 140 , paramdata[8] , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 20 , 110 , "ZZ" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 120 , 110 , paramdata[9] , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	elseif get(PNVLightConfig,3)==0 then
		sasl.gl.drawText ( MainFont2 , 20 , 170 , "Angle" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 120 , 170 , round(get(LightAuto,1),3) , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 20 , 140 , "HDG" , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
		sasl.gl.drawText ( MainFont2 , 120 , 140 , round(get(LightAuto,2),3) , sizetext , false , false , TEXT_ALIGN_LEFT , {1 , 1 , 1 , 1 } )
	end
	--sasl.gl.drawText ( MainFont2 , 20 , 320 , "X - "..sasl.getCSMouseXPos (), 16 , false , false , TEXT_ALIGN_LEFT , {1 , 0 , 1 , 1 } )
--	sasl.gl.drawText ( MainFont2 , 20 , 300 , "Y - "..sasl.getCSMouseYPos (), 16 , false , false , TEXT_ALIGN_LEFT , {1 , 0 , 1 , 1 } )
	if paramdatapressed[1]==1 then
		sasl.gl.drawText ( MainFont2 , 122+sasl.gl.measureText(MainFont2, paramdata[1] , sizetext , false , false) , 352 , "|", 20 , false , false , TEXT_ALIGN_LEFT , {0.25 , 0.64 , 0.95 , 1-blinker} )
	elseif paramdatapressed[2]==1 then
		sasl.gl.drawText ( MainFont2 , 122+sasl.gl.measureText(MainFont2, paramdata[2] , sizetext , false , false) , 322 , "|", 20 , false , false , TEXT_ALIGN_LEFT , {0.25 , 0.64 , 0.95 , 1-blinker} )
	elseif paramdatapressed[3]==1 then
		sasl.gl.drawText ( MainFont2 , 122+sasl.gl.measureText(MainFont2, paramdata[3] , sizetext , false , false) , 292 , "|", 20 , false , false , TEXT_ALIGN_LEFT , {0.25 , 0.64 , 0.95 , 1-blinker} )
	elseif paramdatapressed[4]==1 then
		sasl.gl.drawText ( MainFont2 , 122+sasl.gl.measureText(MainFont2, paramdata[4] , sizetext , false , false) , 262 , "|", 20 , false , false , TEXT_ALIGN_LEFT , {0.25 , 0.64 , 0.95 , 1-blinker} )
	elseif paramdatapressed[5]==1 then
		sasl.gl.drawText ( MainFont2 , 122+sasl.gl.measureText(MainFont2, paramdata[5] , sizetext , false , false) , 232 , "|", 20 , false , false , TEXT_ALIGN_LEFT , {0.25 , 0.64 , 0.95 , 1-blinker} )
	elseif paramdatapressed[6]==1 then
		sasl.gl.drawText ( MainFont2 , 122+sasl.gl.measureText(MainFont2, paramdata[6] , sizetext , false , false) , 202 , "|", 20 , false , false , TEXT_ALIGN_LEFT , {0.25 , 0.64 , 0.95 , 1-blinker} )
	elseif paramdatapressed[7]==1 then
		sasl.gl.drawText ( MainFont2 , 122+sasl.gl.measureText(MainFont2, paramdata[7] , sizetext , false , false) , 172 , "|", 20 , false , false , TEXT_ALIGN_LEFT , {0.25 , 0.64 , 0.95 , 1-blinker} )
	elseif paramdatapressed[8]==1 then
		sasl.gl.drawText ( MainFont2 , 122+sasl.gl.measureText(MainFont2, paramdata[8] , sizetext , false , false) , 142 , "|", 20 , false , false , TEXT_ALIGN_LEFT , {0.25 , 0.64 , 0.95 , 1-blinker} )
	elseif paramdatapressed[9]==1 then
		sasl.gl.drawText ( MainFont2 , 122+sasl.gl.measureText(MainFont2, paramdata[9] , sizetext , false , false) , 112 , "|", 20 , false , false , TEXT_ALIGN_LEFT , {0.25 , 0.64 , 0.95 , 1-blinker} )
	end
end

function onMouseDown(component , x , y , button , parentX , parentY)
	if  button == MB_LEFT then
		if x>10 and x<120 and y>20 and y<55 then
			if get(PNVLightConfig,1)==0 then set(PNVLightConfig,1,1) instanceID=add_light() else set(PNVLightConfig,0,1) hidelight() end
		elseif x>130 and x<240 and y>20 and y<55 then
			if get(PNVLightConfig,1)==1 then
				set(PNVLightConfig,get(PNVLightConfig,3)+1,3)
				if get(PNVLightConfig,3)>2 then set(PNVLightConfig,0,3)  end
			end
		elseif x>260 and x<370 and y>280 and y<315 then
			if get(PNVLightConfig,1)==1 then setcopytext(1) pressed_button[1]=1 end return true
		elseif x>260 and x<370 and y>320 and y<355 then
			if get(PNVLightConfig,1)==1 then setcopytext(2) pressed_button[2]=1 end return true
		elseif x>260 and x<370 and y>230 and y<265 then
			if get(PNVLightConfig,1)==1 then changecamstate() end
		elseif x>260 and x<370 and y>190 and y<225 then
			if get(PNVLightConfig,1)==1 then showhideball() end
		elseif x>260 and x<370 and y>150 and y<185 then
			if get(PNVLightConfig,1)==1 then update_pos() end
		elseif x>260 and x<370 and y>110 and y<145 then
			if get(PNVLightConfig,1)==1 then update_h() end
		elseif x>260 and x<295 and y>20 and y<55 then
			if get(PNVLightConfig,1)==1 then move_pos(90,0.1,0) end
		elseif x>300 and x<335 and y>20 and y<55 then
			if get(PNVLightConfig,1)==1 then move_pos(0,0.1,0) end
		elseif x>300 and x<335 and y>60 and y<95 then
			if get(PNVLightConfig,1)==1 then move_pos(0,-0.1,0) end
		elseif x>340 and x<375 and y>20 and y<55 then
			if get(PNVLightConfig,1)==1 then move_pos(90,-0.1,0) end
		elseif x>120 and x<195 and y>350 and y<370 then
			paramdatapressed={1,0,0,0,0,0,0,0,0}
		elseif x>120 and x<195 and y>320 and y<340 then
			paramdatapressed={0,1,0,0,0,0,0,0,0}
		elseif x>120 and x<195 and y>290 and y<310 then
			paramdatapressed={0,0,1,0,0,0,0,0,0}
		elseif x>120 and x<195 and y>260 and y<280 then
			paramdatapressed={0,0,0,1,0,0,0,0,0}
			set(Light1,round(get(Light1,4),0),4)
			paramdata[4]=tostring(round(get(Light1,4),0))
		elseif x>120 and x<195 and y>230 and y<250 then
			paramdatapressed={0,0,0,0,1,0,0,0,0}
			set(Light1,round(get(Light1,5),0),5)
			paramdata[5]=tostring(round(get(Light1,5),0))
		elseif x>120 and x<195 and y>200 and y<220 then
			paramdatapressed={0,0,0,0,0,1,0,0,0}
		elseif x>120 and x<195 and y>170 and y<190 then
			if get(PNVLightConfig,3)~=0 then paramdatapressed={0,0,0,0,0,0,1,0,0} end
		elseif x>120 and x<195 and y>140 and y<160 then
			if get(PNVLightConfig,3)~=0 then paramdatapressed={0,0,0,0,0,0,0,1,0} end
		elseif x>120 and x<195 and y>110 and y<130 then
			if get(PNVLightConfig,3)~=0 then paramdatapressed={0,0,0,0,0,0,0,0,1} end
		else
			paramdatapressed={0,0,0,0,0,0,0,0,0}
		end
	end
end
function onMouseUp(component , x , y , button , parentX , parentY)
	if  button == MB_LEFT then
		if pressed_button[1]~=0 or pressed_button[2]~=0 then
			pressed_button[1]=0 
			pressed_button[2]=0 
		end
	end
end
function onMouseWheel ( component , x , y , button , parentX , parentY, value )
	if x>120 and x<195 and y>345 and y<375 then
		set(Light1,get(Light1,1)+value*0.01,1)
		if get(Light1,1)<0 then set(Light1,0,1) elseif get(Light1,1)>1 then set(Light1,1,1) end
		setparamdata()
	elseif x>120 and x<195 and y>315 and y<344 then
		set(Light1,get(Light1,2)+value*0.01,2)
		if get(Light1,2)<0 then set(Light1,0,2) elseif get(Light1,2)>1 then set(Light1,1,2) end
		setparamdata()
	elseif x>120 and x<195 and y>285 and y<314 then
		set(Light1,get(Light1,3)+value*0.01,3)
		if get(Light1,3)<0 then set(Light1,0,3) elseif get(Light1,3)>1 then set(Light1,1,3) end
		setparamdata()
	elseif x>120 and x<195 and y>255 and y<284 then
		set(Light1,get(Light1,4)+value*0.1,4)
		if get(Light1,4)<0 then set(Light1,0,4) end
		setparamdata()
	elseif x>120 and x<195 and y>225 and y<254 then
		set(Light1,get(Light1,5)+value*0.5,5)
		if get(Light1,5)<0 then set(Light1,0,5) end
		setparamdata()
	elseif x>120 and x<195 and y>195 and y<224 then
		set(Light1,get(Light1,6)+value*0.001,6)
		if get(Light1,6)<0 then set(Light1,0,6) elseif get(Light1,6)>1 then set(Light1,1,6) end
		setparamdata()
	elseif x>120 and x<195 and y>165 and y<194 then
		if get(PNVLightConfig,3)==2 then
			set(Light1,get(Light1,7)+value*0.001,7)
			setparamdata()
			--if get(Light1,7)<-1 then set(Light1,-1,7) elseif get(Light1,7)>1 then set(Light1,1,7) end
		elseif get(PNVLightConfig,3)==0 then
			set(LightAuto,get(LightAuto,1)+value,1)
			if get(LightAuto,1)<-90 then set(LightAuto,-90,1) elseif get(LightAuto,1)>90 then set(LightAuto,90,1) end
			normalizedvector()
			setparamdata()
		elseif get(PNVLightConfig,3)==1 then
			set(Light1,get(Light1,7)+value*0.001,7)
			if get(Light1,7)<-1 then set(Light1,-1,7) elseif get(Light1,7)>1 then set(Light1,1,7) end
			normilezedvectorpro(get(Light1,7),1)
			setparamdata()
		end
	elseif x>120 and x<195 and y>135 and y<164 then
		if get(PNVLightConfig,3)==2 then
			set(Light1,get(Light1,8)+value*0.001,8)
			setparamdata()
			--if get(Light1,8)<-1 then set(Light1,-1,8) elseif get(Light1,8)>1 then set(Light1,1,8) end
		elseif get(PNVLightConfig,3)==0 then
			set(LightAuto,get(LightAuto,2)+value,2)
			if get(LightAuto,2)<0 then set(LightAuto,0,2) elseif get(LightAuto,2)>360 then set(LightAuto,360,2) end
			normalizedvector()
			setparamdata()
		elseif get(PNVLightConfig,3)==1 then
			set(Light1,get(Light1,8)+value*0.001,8)
			if get(Light1,8)<-1 then set(Light1,-1,8) elseif get(Light1,8)>1 then set(Light1,1,8) end
			normilezedvectorpro(get(Light1,8),2)
			setparamdata()
		end	
	elseif x>120 and x<195 and y>105 and y<134 then
		if get(PNVLightConfig,3)==2 then
			set(Light1,get(Light1,9)+value*0.001,9)
			setparamdata()
			--if get(Light1,9)<-1 then set(Light1,-1,9) elseif get(Light1,9)>1 then set(Light1,1,9) end
		elseif get(PNVLightConfig,3)==0 then
		elseif get(PNVLightConfig,3)==1 then
			set(Light1,get(Light1,9)+value*0.001,9)
			if get(Light1,9)<-1 then set(Light1,-1,9) elseif get(Light1,9)>1 then set(Light1,1,9) end
			normilezedvectorpro(get(Light1,9),3)
			setparamdata()
		end	
	elseif x>390 and x<425 and y>20 and y<55 then
		if get(PNVLightConfig,1)==1 then move_pos(0,0,0.1*value) end
	elseif x>260 and x<295 and y>20 and y<55 then
		if get(PNVLightConfig,1)==1 then move_pos(90,0.1*value,0) end
	elseif x>300 and x<335 and y>20 and y<55 then
		if get(PNVLightConfig,1)==1 then move_pos(0,0.1*value,0) end
	elseif x>300 and x<335 and y>60 and y<95 then
		if get(PNVLightConfig,1)==1 then move_pos(0,-0.1*value,0) end
	elseif x>340 and x<375 and y>20 and y<55 then
		if get(PNVLightConfig,1)==1 then move_pos(90,-0.1*value,0) end
	end
end

function onKeyDown ( component , charr , key , shDown , ctrlDown , altOptDown )
	if paramdatapressed[1]==1 then
		if charr>=48 and charr<=57 or charr==13 or charr==8 then
			if charr==13 then
				paramdatapressed[1]=0
				if string.len(paramdata[1])==0 then
					paramdata[1]=0
				end
			elseif charr==8 then
				paramdata[1]=string.sub(paramdata[1], 0, string.len(paramdata[1])-1)
				if string.len(paramdata[1])==2 then
					paramdata[1]=string.sub(paramdata[1], 0, string.len(paramdata[1])-1)
				end
			else
				if string.len(paramdata[1])<4 then 
					if string.len(paramdata[1])==1 then 
						paramdata[1]=paramdata[1].."."
					end
					paramdata[1]=paramdata[1]..string.char(charr)
				end
			end
			if string.len(paramdata[1])==0 then
				set(Light1,0,1)
			else
				set(Light1,tonumber(paramdata[1]),1)
			end
		end
		return true
	elseif paramdatapressed[2]==1 then
		if charr>=48 and charr<=57 or charr==13 or charr==8 then
			if charr==13 then
				paramdatapressed[2]=0
				if string.len(paramdata[2])==0 then
					paramdata[2]=0
				end
			elseif charr==8 then
				paramdata[2]=string.sub(paramdata[2], 0, string.len(paramdata[2])-1)
				if string.len(paramdata[2])==2 then
					paramdata[2]=string.sub(paramdata[2], 0, string.len(paramdata[2])-1)
				end
			else
				if string.len(paramdata[2])<4 then 
					if string.len(paramdata[2])==1 then 
						paramdata[2]=paramdata[2].."."
					end
					paramdata[2]=paramdata[2]..string.char(charr)
				end
			end
			if string.len(paramdata[2])==0 then
				set(Light1,0,2)
			else
				set(Light1,tonumber(paramdata[2]),2)
			end
		end
		return true
	elseif paramdatapressed[3]==1 then
		if charr>=48 and charr<=57 or charr==13 or charr==8 then
			if charr==13 then
				paramdatapressed[3]=0
				if string.len(paramdata[3])==0 then
					paramdata[3]=0
				end
			elseif charr==8 then
				paramdata[3]=string.sub(paramdata[3], 0, string.len(paramdata[3])-1)
				if string.len(paramdata[3])==2 then
					paramdata[3]=string.sub(paramdata[3], 0, string.len(paramdata[3])-1)
				end
			else
				if string.len(paramdata[3])<4 then 
					if string.len(paramdata[3])==1 then 
						paramdata[3]=paramdata[3].."."
					end
					paramdata[3]=paramdata[3]..string.char(charr)
				end
			end
			if string.len(paramdata[3])==0 then
				set(Light1,0,3)
			else
				set(Light1,tonumber(paramdata[3]),3)
			end
		end
		return true
	elseif paramdatapressed[4]==1 then
		
		if charr>=48 and charr<=57 or charr==13 or charr==8 then
			if charr==13 then
				paramdatapressed[4]=0
				if string.len(paramdata[4])==0 then
					paramdata[4]=0
				end
			elseif charr==8 then
				paramdata[4]=string.sub(paramdata[4], 0, string.len(paramdata[4])-1)
			else
				if string.len(paramdata[4])<4 then
					paramdata[4]=paramdata[4]..string.char(charr)
				end
			end
			if string.len(paramdata[4])==0 then
				set(Light1,0,4)
			else
				set(Light1,tonumber(paramdata[4]),4)
			end
		end
		return true
	elseif paramdatapressed[5]==1 then
		if charr>=48 and charr<=57 or charr==13 or charr==8 then
			if charr==13 then
				
				paramdatapressed[5]=0
				if string.len(paramdata[5])==0 then
					paramdata[5]=0
				end
			elseif charr==8 then
				paramdata[5]=string.sub(paramdata[5], 0, string.len(paramdata[5])-1)
			else
				if string.len(paramdata[5])<4 then 
					paramdata[5]=paramdata[5]..string.char(charr)
				end
			end
			if string.len(paramdata[5])==0 then
				set(Light1,0,5)
			else
				set(Light1,tonumber(paramdata[5]),5)
			end
			
		end
		return true
	elseif paramdatapressed[6]==1 then
		if charr>=48 and charr<=57 or charr==13 or charr==8 then
			if charr==13 then
				paramdata[6]=tostring(round(get(Light1,6),3))
				paramdatapressed[6]=0
				if string.len(paramdata[6])==0 then
					paramdata[6]=0
				end
			elseif charr==8 then
				paramdata[6]=string.sub(paramdata[6], 0, string.len(paramdata[6])-1)
				if string.len(paramdata[6])==2 then
					paramdata[6]=string.sub(paramdata[6], 0, string.len(paramdata[6])-1)
				end
			else
				if string.len(paramdata[6])<5 then 
					if string.len(paramdata[6])==1 then 
						paramdata[6]=paramdata[6].."."
					end
					paramdata[6]=paramdata[6]..string.char(charr)
				end
			end
			if string.len(paramdata[6])==0 then
				set(Light1,0,6)
			else
				set(Light1,tonumber(paramdata[6]),6)
				--print(paramdata[6])
				
			end
		end
		return true
	elseif paramdatapressed[7]==1 then
		if charr>=48 and charr<=57 or charr==13 or charr==8 or charr==43 or charr==45 then
			
			if charr==13 then
				paramdata[7]=tostring(round(get(Light1,7),3))
				paramdatapressed[7]=0
				if string.len(paramdata[7])==0 then
					paramdata[7]=0
				end
			elseif charr==8 then
				paramdata[7]=string.sub(paramdata[7], 0, string.len(paramdata[7])-1)
				if string.sub(paramdata[7], 0, 1)=="-" then
					if string.len(paramdata[7])==3 then
						paramdata[7]=string.sub(paramdata[7], 0, string.len(paramdata[7])-1)
					elseif string.len(paramdata[7])==1 then 
						paramdata[7]=0
					end
				else
					if string.len(paramdata[7])==2 then
						paramdata[7]=string.sub(paramdata[7], 0, string.len(paramdata[7])-1)
					end
				end
			elseif charr==45 then
				if string.sub(paramdata[7], 0, 1)~="-" then
					paramdata[7]="-"..paramdata[7]
				end
			elseif charr==43 then
				if string.sub(paramdata[7], 0, 1)=="-" then
					paramdata[7]=string.sub(paramdata[7], 2)
				end
			else
				if string.sub(paramdata[7], 0, 1)=="-" then
					if string.len(paramdata[7])<6 then 
						if string.len(paramdata[7])==2 then 
								paramdata[7]=paramdata[7].."."
						end
						paramdata[7]=paramdata[7]..string.char(charr)
					end
				else
					if string.len(paramdata[7])<5 then 
						if string.len(paramdata[7])==1 then 
							paramdata[7]=paramdata[7].."."
						end
						paramdata[7]=paramdata[7]..string.char(charr)
					end
				end
				
			end
			if string.len(paramdata[7])==0 then
				set(Light1,0,7)
			else
				set(Light1,tonumber(paramdata[7]),7)
			end
			
			normilezedvectorpro(get(Light1,7),1)
			paramdata[8]=round(get(Light1,8),3)
			paramdata[9]=round(get(Light1,9),3)
		end 
		return true
	elseif paramdatapressed[8]==1 then
		if charr>=48 and charr<=57 or charr==13 or charr==8 or charr==43 or charr==45 then
			
			if charr==13 then
				paramdata[8]=tostring(round(get(Light1,8),3))
				paramdatapressed[8]=0
				if string.len(paramdata[8])==0 then
					paramdata[8]=0
				end
			elseif charr==8 then
				paramdata[8]=string.sub(paramdata[8], 0, string.len(paramdata[8])-1)
				if string.sub(paramdata[8], 0, 1)=="-" then
					if string.len(paramdata[8])==3 then
						paramdata[8]=string.sub(paramdata[8], 0, string.len(paramdata[8])-1)
					elseif string.len(paramdata[8])==1 then 
						paramdata[8]=0
					end
				else
					if string.len(paramdata[8])==2 then
						paramdata[8]=string.sub(paramdata[8], 0, string.len(paramdata[8])-1)
					end
				end
			elseif charr==45 then
				if string.sub(paramdata[8], 0, 1)~="-" then
					paramdata[8]="-"..paramdata[8]
				end
			elseif charr==43 then
				if string.sub(paramdata[8], 0, 1)=="-" then
					paramdata[8]=string.sub(paramdata[8], 2)
				end
			else
				if string.sub(paramdata[8], 0, 1)=="-" then
					if string.len(paramdata[8])<6 then 
						if string.len(paramdata[8])==2 then 
								paramdata[8]=paramdata[8].."."
						end
						paramdata[8]=paramdata[8]..string.char(charr)
					end
				else
					if string.len(paramdata[8])<5 then 
						if string.len(paramdata[8])==1 then 
							paramdata[8]=paramdata[8].."."
						end
						paramdata[8]=paramdata[8]..string.char(charr)
					end
				end
				
			end
			if string.len(paramdata[8])==0 then
				set(Light1,-0.001,8)
			else
				if tonumber(paramdata[8])==0 or paramdata[8]=="-" then
					--print(paramdata[8])
				else
					set(Light1,tonumber(paramdata[8]),8)
				end
			end
			 
			normilezedvectorpro(get(Light1,8),2)
			paramdata[7]=round(get(Light1,7),3)
			paramdata[9]=round(get(Light1,9),3)
		end 
		return true
	elseif paramdatapressed[9]==1 then
		if charr>=48 and charr<=57 or charr==13 or charr==8 or charr==43 or charr==45 then
			
			if charr==13 then
				paramdata[9]=tostring(round(get(Light1,9),3))
				paramdatapressed[9]=0
				if string.len(paramdata[9])==0 then
					paramdata[9]=0
				end
			elseif charr==8 then
				paramdata[9]=string.sub(paramdata[9], 0, string.len(paramdata[9])-1)
				if string.sub(paramdata[9], 0, 1)=="-" then
					if string.len(paramdata[9])==3 then
						paramdata[9]=string.sub(paramdata[9], 0, string.len(paramdata[9])-1)
					elseif string.len(paramdata[9])==1 then 
						paramdata[9]=0
					end
				else
					if string.len(paramdata[9])==2 then
						paramdata[9]=string.sub(paramdata[9], 0, string.len(paramdata[9])-1)
					end
				end
			elseif charr==45 then
				if string.sub(paramdata[9], 0, 1)~="-" then
					paramdata[9]="-"..paramdata[9]
				end
			elseif charr==43 then
				if string.sub(paramdata[9], 0, 1)=="-" then
					paramdata[9]=string.sub(paramdata[9], 2)
				end
			else
				if string.sub(paramdata[9], 0, 1)=="-" then
					if string.len(paramdata[9])<6 then 
						if string.len(paramdata[9])==2 then 
								paramdata[9]=paramdata[9].."."
						end
						paramdata[9]=paramdata[9]..string.char(charr)
					end
				else
					if string.len(paramdata[9])<5 then 
						if string.len(paramdata[9])==1 then 
							paramdata[9]=paramdata[9].."."
						end
						paramdata[9]=paramdata[9]..string.char(charr)
					end
				end
				
			end
			if string.len(paramdata[9])==0 then
				set(Light1,0,9)
			else
				set(Light1,tonumber(paramdata[9]),9)
			end
			
			normilezedvectorpro(get(Light1,9),3)
			paramdata[7]=round(get(Light1,7),3)
			paramdata[8]=round(get(Light1,8),3)
		end 
		return true
	end
end


openmainwindow = sasl.findCommand("PNV/3DLight/popup")
function popupplugin()
	sasl.commandOnce(openmainwindow)
end

MainMenuItem = sasl.appendMenuItem(PLUGINS_MENU_ID , "3D Light Configurator")
MainMenuID = sasl.createMenu("3D Light Configurator", PLUGINS_MENU_ID , MainMenuItem)
PopUpTabletItem = sasl.appendMenuItem(MainMenuID , "Show plugin",popupplugin)
