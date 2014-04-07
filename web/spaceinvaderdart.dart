library spaceinvader;

//-----------------------------------------------------------------------------

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

//-----------------------------------------------------------------------------

part 'Ship.dart';
part 'Ufo.dart';
part 'Bullet.dart';

//-----------------------------------------------------------------------------

Stage stage;
RenderLoop renderLoop;
ResourceManager resourceManager;
Juggler juggler;
Ship ship;
Ufo ufo;
Bullet bullet;


void main() {
  // setup the Stage and RenderLoop
  html.Element canvas = html.querySelector('#stage');
  stage = new Stage(canvas,webGL:true);
  renderLoop = new RenderLoop();
  juggler = renderLoop.juggler;
  renderLoop.addStage(stage);

  //Making a resourceManager and adding resources
  resourceManager = new ResourceManager()
    ..addBitmapData("ship", "images/playerShip1_blue.png")
    ..addBitmapData("bullet","images/laserBlue01.png")
    ..addBitmapData("ufo","images/ufoRed.png")
    ..addBitmapData("background","images/purple.png");
  
  //loading resources via resourceManager
  resourceManager.load().then((_){

	  int tileHeight = resourceManager.getBitmapData("background").height;
	  int tileWidth = resourceManager.getBitmapData("background").width;

		int yTimes = (600 / tileHeight).ceil();
		int xTimes = (800 / tileWidth).ceil();

	  //Creating background
	  Sprite sprite = new Sprite();
	  for(int i=0;i < yTimes;i++){
		  for(int j=0;j < xTimes;j++){
				Bitmap backgroundTile = new Bitmap(resourceManager.getBitmapData("background"));
			  backgroundTile.x = backgroundTile.width * j;
			  backgroundTile.y = backgroundTile.height * i;
			  sprite.addChild(backgroundTile);
		  }
	  }
	  stage.addChild(sprite);


    //Making our ship and ufo
    ship = new Ship(resourceManager.getBitmapData("ship"),100,100);

    //List of bullets
    List<Bullet> bulletList = new List<Bullet>();

    List<Bullet> aliveBulletList = new List<Bullet>();

    //Making the list
    for(var i=0;i < 5;i++){
	    bulletList.add(new Bullet(resourceManager.getBitmapData("bullet"),0,200));
    }

    //list of Ufos
    List<Ufo> ufoList = new List<Ufo>();

    //Making the list
    for(var i=1;i < 8;i++){
			ufo = new Ufo(resourceManager.getBitmapData("ufo"),i*100,50);
	    ufoList.add(ufo);
	    stage.addChild(ufo);
    }

    //add the ship to the stage and the juggler
    stage.addChild(ship);
    stage.juggler.add(ship);



    //the stage needs to be an interactive object,
    //so we can use it for keyboard events
    stage.focus = stage;
    
    //spacebar
    const spaceBar = 32;

    //cursor keys
    const leftArrow = 37;
    const upArrow = 38;
    const rightArrow = 39;
    const downArrow = 40;

    //Event handling for cursor KeyDown events
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

      //shooting bullet
      if(value.keyCode == spaceBar){
	      bullet = bulletList.firstWhere((item)=> item.alive == false)
	        ..x = ship.x
	        ..y = ship.y - ship.height
	        ..alive = true;

	      stage.addChild(bullet);
	      stage.juggler.add(bullet);
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

    //Event listener for every frame
	  stage.onEnterFrame.listen((_){
		  //get alive bullets
		  aliveBulletList.addAll(bulletList.where((item)=> item.alive==true));

		  //test if bullet hit an ufo
			aliveBulletList.forEach((alien){
				ufoList.forEach((ufo){
					if(ufo.hitTestObject(alien)){
						stage.removeChild(ufo);
						alien.alive = false;
					}
				});
			});

		  aliveBulletList.clear();

	  });
  
  });
}
