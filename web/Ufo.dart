part of spaceinvader;

class Ufo extends Bitmap implements Animatable{

	num _x, _y;
	num _vx, _vy;
	bool _movingRight = true;
	Tween _tween;

	Ufo(BitmapData bitmapData,this._x,this._y,this._vx,this._vy) : super(bitmapData){
		pivotX = bitmapData.width / 2;
		pivotY = bitmapData.height / 2;
		x = _x;
		y = _y;

	}

	bool advanceTime(num time){
		if(x <= width/2 || x >= 800 - width/2){
			this._movingRight = !this._movingRight;

			_tween = new Tween(this,0.4,TransitionFunction.linear);
			_tween.animate.y.to(y+100);
			stage.juggler.add(_tween);

		}

		if(this._movingRight){
			x = x + _vx * time;
		}else{
			x = x - _vx * time;
		}
	}
}
