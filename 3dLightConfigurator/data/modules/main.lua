size = { 2048, 2048 }

screen_height=globalPropertyi("sim/graphics/view/window_height",false)
screen_width=globalPropertyi("sim/graphics/view/window_width",false)
popupmain = sasl.createCommand ( "PNV/3DLight/popup" , "Popup main window" )

Light1=createGlobalPropertyfa ( "PNV/lights/light1", {1,1,1,3,10,0.7,0,-1,0} , false , false )
LightAuto=createGlobalPropertyfa ( "PNV/lights/lightAuto", {-90,0,1000} , false , false )
PNVLightConfig=createGlobalPropertyfa ( "PNV/lights/sett", {0,1,0,0,0,0,0,0,0} , false , false ) -- 1-show obj, 2-show ball, 3-manual mode
lampdataref1=createGlobalPropertyf ( "PNV/light/lampdataref1", 0 , false , false )
--sasl.options.set3DRendering(false)


mainpanel = subpanel {

    position = { 0, 0, 450, 450 };
    noBackground = true;
	visible=true;
	noClose = false;
	noMove = true;
	savePosition = true;
	pinnedToXWindow = {false,false};
	noResize = true;
    command = "PNV/3DLight/popup";
    description = "Toggle Main window";
	components = {
        interface {  position = { 0, 0, 450, 450 } };
    };


};
