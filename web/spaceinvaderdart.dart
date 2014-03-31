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
    Ship ship = new Ship(resourceManager.getBitmapData("ship"),100,100);

    //add the ship to the stage and the juggler
    stage.addChild(ship);
    stage.juggler.add(ship);
    
    //the stage needs to be an interactive object,
    //so we can use it for keyboard events
    stage.focus = stage;
    
    //cursor keys
    const leftArrow = 37;
    const upArrow = 38;
    const rightArrow = 39;
    const downArrow = 40;

    //Event handling for cursor keys onKeyDown events
    // value is a Keyboard event
    stage.onKeyDown.listen((value){
      //print(value.keyCode);

      //switch statemant to decide which cursor keys was down
      switch(value.keyCode){
          case leftArrow:
            ship.movingLeft = true;
            break;
          case upArrow:
            ship.movingUp = true;
            break;
          case rightArrow:
            ship.movingRight = true;
            break;
          case downArrow:
            ship.movingDown = true;
            break;
      }
        
    });

    //Event listener for cursor keyUP events
    stage.onKeyUp.listen((value){

      switch(value.keyCode){
        case leftArrow:
          ship.movingLeft = false;
          break;
        case upArrow:
          ship.movingUp = false;
          break;
        case rightArrow:
          ship.movingRight = false;
          break;
        case downArrow:
          ship.movingDown = false;
          break;
      }

    });
  
  });
}
