part of spaceinvader;

class Ufo extends Bitmap {

	num _x, _y;

	Ufo(BitmapData bitmapData,this._x,this._y) : super(bitmapData){
		this.pivotX = bitmapData.width / 2;
		this.pivotY = bitmapData.height / 2;
		this.x = _x;
		this.y = _y;
	}

	/*bool advanceTime(num time){

	}*/
}
