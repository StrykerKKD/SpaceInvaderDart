part of spaceinvader;

class Bullet extends Bitmap implements Animatable  {
	num _vx, _vy;
	bool alive = false;

	Bullet(BitmapData bitmapData,this._vx,this._vy) : super(bitmapData){
		this.pivotX = bitmapData.width / 2;
		this.pivotY = bitmapData.height / 2;
	}

	bool advanceTime(num time){
		//kill it before it reaches the upper border of the stage
		if(y <= this.height/2 || this.alive==false){
			stage.removeChild(this);
			stage.juggler.remove(this);
			this.alive = false;
		}
		y = y - _vy * time;
	}
}
