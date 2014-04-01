part of spaceinvader;

class Ufo extends Bitmap {

	num _vx, _vy;

	Ufo(BitmapData bitmapData,this._vx,this._vy) : super(bitmapData){
		this.pivotX = bitmapData.width / 2;
		this.pivotY = bitmapData.height / 2;
		this.x = 400;
		this.y = 50;
	}

	/*bool advanceTime(num time){

	}*/
}
