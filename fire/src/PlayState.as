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
		private var wind_bar_frame:FlxSprite;
		private var wind_bar_inside:FlxSprite;
		private var wind_bar_bar:FlxSprite;
		
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
			wind = new Wind(100, 5, 10);
			// init wind-bar
			/*
			wind_bar_frame = new FlxSprite(4,4);
			wind_bar_frame.createGraphic(50,10); //White frame for the health bar
			wind_bar_frame.scrollFactor.x = wind_bar_frame.scrollFactor.y = 0;
			add(wind_bar_frame);
			
			var inside:FlxSprite = new FlxSprite(5,5);
			inside.createGraphic(48,8,0xff000000); //Black interior, 48 pixels wide
			inside.scrollFactor.x = inside.scrollFactor.y = 0;
			add(inside);
			
			var bar:FlxSprite = new FlxSprite(5,5);
			bar.createGraphic(1,8,0xffff0000); //The red bar itself
			bar.scrollFactor.x = bar.scrollFactor.y = 0;
			bar.origin.x = bar.origin.y = 0; //Zero out the origin
			bar.scale.x = 48; //Fill up the health bar all the way
			add(bar);
			
			bar.scale.x = 24; //Drop the health bar to half
			*/
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