package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../images/wald.png")] private var Tiles:Class;
		[Embed(source = '../data/tilemap.txt', mimeType = "application/octet-stream")] private var Map:Class;

		public var mapLayer:FlxGroup;
		public var map:FlxTilemap;
		
		private var mapElements:Array = new Array();
		private var activeElements:Array = new Array();
		
		private var wind:Wind;
		private var stuff:BurningStuff;
		
		override public function create():void
		{
			initMap();
			initArray();
			this.add(mapLayer);
		}
		
		override public function update():void  
		{
			super.update();
			/*
			if(FlxG.keys.justPressed("B")) {
				map.setTile(1,1,2,true);
			}
			if(FlxG.keys.justPressed("N")) {
				map.setTile(1,1,0,true);
			}
			*/
			
		}
		
		public function initMap():void
		{
			mapLayer = new FlxGroup();
			map = new FlxTilemap();
			map.drawIndex = 0;
			map.loadMap(new Map, Tiles, 48);
			mapLayer.add(map);
		}
		
		public function initArray():void
		{
			for (var x:int=0; x<4; x++) {
				mapElements[x] = new Array();
				for (var y:int=0; y<4; y++) {
					switch (map.getTile(x,y)) {
						case 0:
							mapElements[x][y] = new BurningStuff("Tree",100,10,30);
							break ;
						case 1:
							mapElements[x][y] = new BurningStuff("Tree",100,10,30);
							break ;
						case 2:
							mapElements[x][y] = new BurningStuff("Tree",100,10,30);
							break ;
						case 3:
							mapElements[x][y] = new BurningStuff("Tree",100,10,30);
							break ;
						default:
							mapElements[x][y] = new BurningStuff("Tree",100,10,30);
					} 
				}
			}
			
		}

		public function initWindbar():void
		{
		
		}
		
		public function calculateBurning():void
		{
			// we have a two dimensional array containing our burningStuff 
			// objects, according to the tilemap
			
			// we also have an array containing all burning objects
			// iterate through those and call the apropiate method (e.g. 
			// decreaseThreshold) for neighbours
			
			// how do we find the neighbours?
			
			// when do we set neighbours on fire?
		}
		
	}
}