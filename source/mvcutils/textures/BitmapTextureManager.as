package mvcutils.textures {
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import starling.textures.Texture;

	public class BitmapTextureManager extends AbstractTextureManager {

		public function BitmapTextureManager() {
			super();
		};

		[Inline]
		protected function addBDTexture(pID:String, pTexture:BitmapData):void {
			addTexure(pID, Texture.fromBitmapData(pTexture, false, false));
		}

		[Inline]
		protected function addBitmapTexture(pID:String, pTexture:Bitmap):void {
			addBDTexture(pID, pTexture.bitmapData);
		}
	}
}