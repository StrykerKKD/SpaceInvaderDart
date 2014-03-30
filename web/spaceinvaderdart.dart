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
  stage = new Stage(canvas);
  renderLoop = new RenderLoop();
  juggler = renderLoop.juggler;
  renderLoop.addStage(stage);
  
  //Making a resourceManager and 
  resourceManager = new ResourceManager()
    ..addBitmapData("ship", "./assets/playerShip1_blue.png");
  
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
    const left_arrow = 37;
    const up_arrow = 38;
    const right_arrow = 39;
    const down_arrow = 40;

    //speed of the ship
    int speed = 20;

    //Event handling for cursor keys, onKeyDown return a Keyboard event 
    stage.onKeyDown.listen((value){
      //print(value.keyCode);

      tween = new Tween(ship, 0.1, TransitionFunction.linear);

      //switch statemant to decide which cursor keys was down
      switch(value.keyCode){
          case left_arrow:
            tween.animate.x.to(ship.x-speed);
            juggler.add(tween);
            break;
          case up_arrow:
            tween.animate.y.to(ship.y-speed);
            juggler.add(tween);
            break;
          case right_arrow:
            tween.animate.x.to(ship.x+speed);
            juggler.add(tween);
            break;
          case down_arrow:
            tween.animate.y.to(ship.y+speed);
            juggler.add(tween);
            break;
      }
        
    });    
  
  });
}
