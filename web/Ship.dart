part of spaceinvader;

class Ship extends Bitmap implements Animatable {

  num _vx, _vy;
  bool movingLeft = false;
  bool movingRight = false;
  bool movingUp = false;
  bool movingDown = false;

  Ship(BitmapData bitmapData,this._vx,this._vy) : super(bitmapData) {
    pivotX = bitmapData.width / 2;
    pivotY = bitmapData.height / 2;
    x = 400;
    y = 500;
  }

  bool advanceTime(num time){
    if(movingLeft){
      x = x - _vx * time;
    }else if(movingRight){
      x = x + _vx * time;
    }
    if(movingUp){
      y = y - _vy * time;
    }else if(movingDown){
      y = y + _vy * time;
    }
    return true;
  }

}
