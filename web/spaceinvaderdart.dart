import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

void main() {
  // setup the Stage and RenderLoop
  var canvas = html.querySelector('#stage');
  Stage stage = new Stage(canvas);
  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  
  //Making a resourceManager and 
  ResourceManager resourceManager = new ResourceManager()
    ..addBitmapData("ship", "./assets/playerShip1_blue.png");
  
  //loading resources via resourceManager
  resourceManager.load().then((_){
    //making our ship
    Bitmap ship = new Bitmap(resourceManager.getBitmapData("ship"));
    
    //add the ship to the stage
    stage.addChild(ship);
    
    //the stage needs to be an interactive object,
    //so we can use it for keyboard events
    stage.focus = stage;
    
    //cursor keys
    const left_arrow = 37;
    const up_arrow = 38;
    const right_arrow = 39;
    const down_arrow = 40;


    //Event handling for cursor keys, onKeyDown return a Keyboard event 
    stage.onKeyDown.listen((value){
      //print(value.keyCode);
      
      //switch statemant to decide which cursor keys was down
      switch(value.keyCode){
          case left_arrow:
            ship.x += -10;
            break;
          case up_arrow:
            ship.y += -10;
            break;
          case right_arrow:
            ship.x += 10;
            break;
          case down_arrow:
            ship.y += 10;
            break;
      }
        
    });    
  
  });
}
