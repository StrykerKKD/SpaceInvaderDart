part of spaceinvader;

class Bullet extends Bitmap implements Animatable  {
	num _vx, _vy;

	Bullet(BitmapData bitmapData,this._vx,this._vy) : super(bitmapData){
		this.pivotX = bitmapData.width / 2;
		this.pivotY = bitmapData.height / 2;
	}

	bool advanceTime(num time){
		//kill it before it reaches the upper border of the stage
		if(y <= this.height){
			stage.removeChild(this);
			stage.juggler.remove(this);
		}
		y = y - _vy * time;
	}
}