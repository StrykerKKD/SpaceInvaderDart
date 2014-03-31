library spaceinvader;

//-----------------------------------------------------------------------------

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

//-----------------------------------------------------------------------------

part 'Ship.dart';

//-----------------------------------------------------------------------------

Stage stage;
RenderLoop renderLoop;
ResourceManager resourceManager;
Juggler juggler;
Tween tween;

void main() {
  // setup the Stage and RenderLoop
  html.Element canvas = html.querySelector('#stage');
  stage = new Stage(canvas,webGL:true);
  renderLoop = new RenderLoop();
  juggler = renderLoop.juggler;
  renderLoop.addStage(stage);

  //Making a resourceManager and 
  resourceManager = new ResourceManager()
    ..addBitmapData("ship", "images/playerShip1_blue.png");
  
  //loading resources via resourceManager
  resourceManager.load().then((_){
    //making our ship
    Bitmap ship = new Bitmap(resourceManager.getBitmapData("ship"));
    
    //add the ship to the stage
    stage.addChild(ship);
    ship.x = 400;
    ship.y = 300;
    
    //the stage needs to be an interactive object,
    //so we can use it for keyboard events
    stage.focus = stage;
    
    //cursor keys
    const leftArrow = 37;
    const upArrow = 38;
    const rightArrow = 39;
    const downArrow = 40;

    //calculating the speed of the ship
    int distanceInPixels = 50;
    double timeInSeconds = 0.5;
    int speed = (distanceInPixels/timeInSeconds).round();

    //Event handling for cursor keys onKeyDown events
    // value is a Keyboard event
    stage.onKeyDown.listen((value){
      //print(value.keyCode);

      tween = new Tween(ship, timeInSeconds, TransitionFunction.linear);

      //switch statemant to decide which cursor keys was down
      switch(value.keyCode){
          case leftArrow:
            tween.animate.x.to(ship.x-speed);
            juggler.add(tween);
            break;
          case upArrow:
            tween.animate.y.to(ship.y-speed);
            juggler.add(tween);
            break;
          case rightArrow:
            tween.animate.x.to(ship.x+speed);
            juggler.add(tween);
            break;
          case downArrow:
            tween.animate.y.to(ship.y+speed);
            juggler.add(tween);
            break;
      }
        
    });

    //Event listener for cursor keyUP events
    stage.onKeyUp.listen((value){

      //the keycode is a cursor key
      if(value.keyCode >= 37 || value.keyCode <= 40){
        juggler.removeTweens(ship);
      }

    });
  
  });
}
