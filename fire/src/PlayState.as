package
{
	
	import flashx.textLayout.formats.Float;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../images/inc_tileset.png")] private var Tiles:Class;
		[Embed(source = '../data/tilemap.txt', mimeType = "application/octet-stream")] private var Map:Class;
		[Embed(source = '../data/tilemap_new.txt', mimeType = "application/octet-stream")] private var Map2:Class;
		[Embed(source = '../data/tilemap_3.txt', mimeType = "application/octet-stream")] private var Map3:Class;
		[Embed(source="../data/wind.mp3")] public var WindSound:Class;
		[Embed(source="../data/fire.mp3")] public var FireSound:Class;
		
		public var mapLayer:FlxGroup;
		public var map:FlxTilemap;
		
		private var mapElements:Array = new Array();
		private var damageArray:Array = new Array();
		
		private var activeElements:Array= new Array();
		private var startPoint:FlxPoint = new FlxPoint(); 
		private var mapWidth:int = 13;
		private var mapHeight:int = 10;
		
		private var wind:Wind;
		private var windDirection:int = -1;
		private var scoreFlxTxt:FlxText;
		private var scoreTxt:String;
		private var scoreCount:int = 0;
		private var defaultFireEnergy:int = 0;
		private var wind_bar_frame:FlxSprite;
		private var wind_bar_inside:FlxSprite;
		private var wind_bar_bar:FlxSprite;
		
		// i think those are testing only
		private var stuff:BurningStuff;
		private var firesprite:FireSprite;
		
		private var text:FlxText;
		
		private var gameOver:Boolean = false;
		
		private var bonusFlxTxt:FlxText;
		
		private var counter:int = 0;
		
		private var fireCount:int = 0;

		private var windSound:FlxSound;
		private var fireSound:FlxSound;

		private var showMiniScores:Boolean = false;
		
		private var actLevel:String;
		private var wind_animation:WindSprite;
		private var empty_sprite:WindSprite;
		private var save_wind_sprite:WindSprite;
		
		override public function PlayState(level:int):void
		{
			super.update();
			FlxG.level = level;
			if(FlxG.level==1){actLevel = new Map;}
			if(FlxG.level==2){actLevel = new Map2;}
			if(FlxG.level==3){actLevel = new Map3;}
			scoreCount = FlxG.scores[0];
			
		}
		
		override public function create():void
		{
			initMap();
			initArray();
			
			// adds the tileset to the game
			this.add(mapLayer);
			
			// initialize firesprite testing only
			//firesprite = new FireSprite();
			//this.add(firesprite);
			
			// set fire start place
			startPoint = new FlxPoint(1,1);
			var bs:BurningStuff = mapElements[startPoint.x][startPoint.y].setOnFire();
			map.setTile(startPoint.x,startPoint.y,map.getTile(startPoint.x,startPoint.y)+1,true);
			activeElements[0] = startPoint;
			
			// add windbar (and initialize wind)
			initWind();
			
			// init wind sound
			windSound = new FlxSound();
			windSound.loadEmbedded(WindSound, true);
			windSound.volume = 0.1;
			windSound.play();
			
			// init firesound
			fireSound = new FlxSound();
			fireSound.loadEmbedded(FireSound, true);
			fireSound.volume = 0.1
			fireSound.play();
			
			// debug text
			//text = new FlxText(0,30,100,"Hello, World!")
			//this.add(text);
			initScore();
			initDamageArray();
			initWindAnimation();
		}
		
		override public function update():void  
		{
			super.update();
			
			if (!gameOver) {
				if (showMiniScores) {
					resetDamageArray();
					burn();
					makeDamageArray();
				} else {
					burn();
				}
			}		
			
			// reset
			if (FlxG.keys.justPressed("R")) {
				FlxG.scores[0] = 0;
				FlxG.scores[1] = 0;
				FlxG.scores[2] = 0;
				FlxG.scores[3] = 0;
				FlxG.state = new PlayState(1);
			}
				
			
			// level 1
			if (FlxG.keys.justPressed("ONE"))
				FlxG.state = new PlayState(1);
			
			// level 2
			if (FlxG.keys.justPressed("TWO"))
				FlxG.state = new PlayState(2);
			
			// level 3
			if (FlxG.keys.justPressed("THREE"))
				FlxG.state = new PlayState(3);
			
			// level 3
			if (FlxG.keys.justPressed("M"))
				FlxG.state = new WelcomeState();
			
			// miniscores
			if (FlxG.keys.justPressed("S"))
				if (!showMiniScores) showMiniScores = true;
				else showMiniScores = false;
			
			// handle keystrokes
			if (FlxG.keys.UP || FlxG.keys.RIGHT || FlxG.keys.DOWN || FlxG.keys.LEFT)
			{
				// find out which direction
				if (FlxG.keys.UP && FlxG.keys.RIGHT)
					wind.setDirection(1);
				else if (FlxG.keys.UP && FlxG.keys.LEFT)
					wind.setDirection(7);
				else if (FlxG.keys.DOWN && FlxG.keys.RIGHT)
					wind.setDirection(3);
				else if (FlxG.keys.DOWN && FlxG.keys.LEFT)
					wind.setDirection(5);
				else if (FlxG.keys.UP )
					wind.setDirection(0);
				else if (FlxG.keys.RIGHT)
					wind.setDirection(2);
				else if (FlxG.keys.DOWN)
					wind.setDirection(4);
				else if (FlxG.keys.LEFT)
					wind.setDirection(6);
				
				// set wind as active
				wind.setActive(true);
				
				// decrease wind-power	
				wind.blow();
			}
			else
			{
				// set wind as not active
				wind.setActive(false);
				
				// regain wind-power
				wind.refresh();
			}
			
			// refresh wind bar
			//var windFactor:int = (wind.getEnergyLevel()/100);
			wind_bar_bar.scale.x = wind.getEnergyLevel();
			wind_bar_bar.alpha = (wind.getEnergyLevel()/100);	
			
			// draw Wind
			if (wind.isActive() && wind.getDirection() != -1) {
				startWindAnimation(((360/8)*wind.getDirection())-90);
				wind_animation.alpha = Math.max(Math.sqrt(wind.getEnergyLevel()/100),0.2);
			} else { 
				stopWindAnimation();
			}
			
			// play wind sound
			if (wind.isActive())
			{	
				windSound.volume = (wind.getEnergyLevel()/100);
			}
			else
			{
				windSound.volume = 0.1;
			}
			
			// take care of fire sound
			if (fireCount >= 10)
			{
				fireSound.volume = 1;
			}
			else
			{
				fireSound.volume = fireCount / 10;
			}
				
			if (gameOver == true)
			{
				if (text == null)
					initEndMessage();
				if (FlxG.level < 3) {
					text.text = "PRESS ENTER TO PROCEED TO NEXT LEVEL!!";
					if(FlxG.keys.justPressed("ENTER"))
					{
						var score:int = int((scoreCount/100).toFixed(0))*100;
						FlxG.scores[0] = score;
						FlxG.scores[FlxG.level] = score;
						FlxG.state = new PlayState(FlxG.level+1);
					}
				} else {
					text.text = "YOU'VE BEEN EXTINGUISHED!!!\n\nPRESS ENTER TO PLAY AGAIN\n\nYOUR FINAL SCORE:\n"+int((scoreCount/100).toFixed(0))*100+"\n\nPRESS SPACE TO TWITTER YOUR RESULT!";
					text.y = 100;
					if(FlxG.keys.justPressed("ENTER"))
					{
						FlxG.scores[0] = 0;
						FlxG.scores[1] = 0;
						FlxG.scores[2] = 0;
						FlxG.scores[3] = 0;
						FlxG.state = new PlayState(1);
					}
					if(FlxG.keys.justPressed("SPACE"))
					{
						FlxU.openURL("http://twitter.com/home?status=I played Fire and got a Score of "+int((scoreCount/100).toFixed(0))*100+"!");
					}
				}
				text.setFormat(null, 30, 0xffffffff, "center", 0);
				this.add(text);
				
				// stop/fade out sounds
				windSound.fadeOut(2, true);
				fireSound.fadeOut(2, true);
			}
		}
		
		public function initEndMessage():void {
			text = new FlxText(0, 200, FlxG.width, " ");
			text.setFormat(null, 30, 0xffffffff, "center", 0);
			this.add(text);
		}
		
		public function burn():void
		{
			var actMapPos:FlxPoint;
			var nullCounter:int=0;
			//initDamageArray();
			
			//var actBurnStuff:BurningStuff;
			for (var i:int=0; i<activeElements.length; i++)
			{
				if (!(activeElements[i] == null)) {
					// init
					actMapPos = activeElements[i] as FlxPoint;
					defaultFireEnergy = mapElements[actMapPos.x][actMapPos.y].getBurnEnergy();
					// check wind
					if (wind.isActive())
						windDirection = wind.getDirection();
					
					// check surrounding
					if (mapElements[actMapPos.x][actMapPos.y].getNeighbourhoodValue() == 0) {
						scorch(new FlxPoint(actMapPos.x-1,actMapPos.y-1),7);
						scorch(new FlxPoint(actMapPos.x,actMapPos.y-1),0);
						scorch(new FlxPoint(actMapPos.x+1,actMapPos.y-1),1);
						scorch(new FlxPoint(actMapPos.x-1,actMapPos.y),6);						
						scorch(new FlxPoint(actMapPos.x+1,actMapPos.y),2);
						scorch(new FlxPoint(actMapPos.x-1,actMapPos.y+1),5);
						scorch(new FlxPoint(actMapPos.x,actMapPos.y+1),4);
						scorch(new FlxPoint(actMapPos.x+1,actMapPos.y+1),3);
					} else if (mapElements[actMapPos.x][actMapPos.y].getNeighbourhoodValue() == 1) {
						if (mapElements[actMapPos.x][actMapPos.y].getNeighboursUp()) {
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y-1),7);
							scorch(new FlxPoint(actMapPos.x,actMapPos.y-1),0);
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y-1),1);
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y),6);				
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y),2);
						} else {
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y),6);						
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y),2);
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y+1),5);
							scorch(new FlxPoint(actMapPos.x,actMapPos.y+1),4);
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y+1),3);
						}
					} else if (mapElements[actMapPos.x][actMapPos.y].getNeighbourhoodValue() == 2) {
						if (mapElements[actMapPos.x][actMapPos.y].getNeighboursLeft()) {
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y-1),7);
							scorch(new FlxPoint(actMapPos.x,actMapPos.y-1),0);							
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y),6);														
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y+1),5);
							scorch(new FlxPoint(actMapPos.x,actMapPos.y+1),4);							
						} else {						
							scorch(new FlxPoint(actMapPos.x,actMapPos.y-1),0);
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y-1),1);													
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y),2);							
							scorch(new FlxPoint(actMapPos.x,actMapPos.y+1),4);
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y+1),3);						}
					} else if (mapElements[actMapPos.x][actMapPos.y].getNeighbourhoodValue() == 3) {
						if (!mapElements[actMapPos.x][actMapPos.y].getNeighboursLeft() && !mapElements[actMapPos.x][actMapPos.y].getNeighboursUp()) {							
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y),2);							
							scorch(new FlxPoint(actMapPos.x,actMapPos.y+1),4);
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y+1),3);
						} else if (!mapElements[actMapPos.x][actMapPos.y].getNeighboursUp() && !mapElements[actMapPos.x][actMapPos.y].getNeighboursRight()) {
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y),6);														
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y+1),5);
							scorch(new FlxPoint(actMapPos.x,actMapPos.y+1),4);																
						} else if (!mapElements[actMapPos.x][actMapPos.y].getNeighboursRight() && !mapElements[actMapPos.x][actMapPos.y].getNeighboursDown()) {
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y-1),7);
							scorch(new FlxPoint(actMapPos.x,actMapPos.y-1),0);							
							scorch(new FlxPoint(actMapPos.x-1,actMapPos.y),6);														
						} else if (!mapElements[actMapPos.x][actMapPos.y].getNeighboursDown() && !mapElements[actMapPos.x][actMapPos.y].getNeighboursLeft()) {						
							scorch(new FlxPoint(actMapPos.x,actMapPos.y-1),0);
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y-1),1);														
							scorch(new FlxPoint(actMapPos.x+1,actMapPos.y),2);
				
						} 
					}
					defaultFireEnergy = 0;
					
					// check duration
					if (!mapElements[actMapPos.x][actMapPos.y].decreaseDuration(1)) {
						map.setTile(actMapPos.x,actMapPos.y,map.getTile(actMapPos.x,actMapPos.y)+1,true);
						activeElements[i]=null;
					}
				} else {
					nullCounter++;
				}
			}
			
			// set gameover
			if (nullCounter == activeElements.length)
				gameOver=true;
			
			// set fireplaces
			fireCount = activeElements.length-nullCounter;
			
			windDirection = -1;
			
			// update score
			scoreFlxTxt.text = "SCORE: "+int((scoreCount/100).toFixed(0))*100;
		}
		
		public function scorch(point:FlxPoint, direction:int):void {
			var value:int = defaultFireEnergy;
			if (direction == windDirection) 
			{
				value = value*5*int(10*(wind.getEnergyLevel()/100));
				mapElements[point.x][point.y].startBurningSmokeAnimation();
			} 
			else 
			{
				mapElements[point.x][point.y].startSmokeAnimation();
			}
			if (direction == 1 || direction == 3 || direction == 5 || direction == 7)
				value /= 2;
			scoreCount += value;
			if (!mapElements[point.x][point.y].isBurnt() && !mapElements[point.x][point.y].isBurning()) {
				//var test:Boolean = !mapElements[point.x][point.y].decreaseThreshold(value)
				if (!mapElements[point.x][point.y].decreaseThreshold(value)) {
					map.setTile(point.x,point.y,map.getTile(point.x,point.y)+1,true);
					for (var i:int=0; i<activeElements.length; i++)
					{
						if (activeElements[i]==null) {
							activeElements[i] = point;
							return;
						}
					}
					activeElements.push(point);
				} else {
					damageArray[point.x][point.y][0] += value;
				}
			}
		}
		
		public function initScore():void
		{
			scoreFlxTxt = new FlxText(200, 10, 200, "Score: 0");
			scoreFlxTxt.setFormat(null, 20, 0xffffffff, "center", 0);
			this.add(scoreFlxTxt);
		}
		
		public function initMap():void
		{
			mapLayer = new FlxGroup();
			map = new FlxTilemap();
			map.drawIndex = 0;
			map.loadMap(actLevel, Tiles, 48);
			mapLayer.add(map);
		}
		
		public function initArray():void
		{
			for (var x:int=0; x<mapWidth; x++) {
				mapElements[x] = new Array();
				for (var y:int=0; y<mapHeight; y++) {
					switch (map.getTile(x,y)) {
						case 0:
							mapElements[x][y] = new BurningStuff("Grass",2000,400,2);
							break ;
						case 3:
							mapElements[x][y] = new BurningStuff("Wald",5000,400,4);
							break ;
						case 6:
							mapElements[x][y] = new BurningStuff("Stadt",14000,400,5);
							break ;
						case 9:
							mapElements[x][y] = new BurningStuff("See",21000,400,4);
							break ;
						//default:
							//mapElements[x][y] = new BurningStuff("Grass",200,300,3);
					} 
					if (y-1<0)
						mapElements[x][y].setNeighboursUp(false);
					if (x+1>=mapWidth)
						mapElements[x][y].setNeighboursRight(false);
					if (y+1>=mapHeight)
						mapElements[x][y].setNeighboursDown(false);
					if (x-1<0)
						mapElements[x][y].setNeighboursLeft(false);
					mapElements[x][y].checkNeighbours();
					mapElements[x][y].setTileX(x);
					mapElements[x][y].setTileY(y);
					mapElements[x][y].setPlayState(this);
				}
			}
			
		}

		public function initWind():void
		{
			// init wind object
			wind = new Wind(100, 75, 1, 2);
			
			// init wind-bar			
			wind_bar_frame = new FlxSprite(4,4);
			wind_bar_frame.createGraphic(102,10); //White frame for the health bar
			wind_bar_frame.scrollFactor.x = wind_bar_frame.scrollFactor.y = 0;
			this.add(wind_bar_frame);
			
			
			wind_bar_inside = new FlxSprite(5,5);
			wind_bar_inside.createGraphic(100,8,0xffffffff); //Black interior, 48 pixels wide
			wind_bar_inside.scrollFactor.x = wind_bar_inside.scrollFactor.y = 0;
			add(wind_bar_inside);
			
			
			wind_bar_bar = new FlxSprite(5,5);
			wind_bar_bar.createGraphic(1,8,0xff33aaff); //The blue bar itself
			wind_bar_bar.scrollFactor.x = wind_bar_bar.scrollFactor.y = 0;
			wind_bar_bar.origin.x = wind_bar_bar.origin.y = 0; //Zero out the origin
			wind_bar_bar.scale.x = wind.getEnergyLevel(); //Fill up the health bar all the way
			add(wind_bar_bar);
			
		}
		
		public function initDamageArray():void {
			for (var x:int=0; x<mapWidth; x++) {
				damageArray[x] = new Array();
				for (var y:int=0; y<mapHeight; y++) {
					damageArray[x][y] = new Array();
					damageArray[x][y][0] = 0;
					damageArray[x][y][1] = new FlxText(x*48+13, y*48+29, 40, " ");
					damageArray[x][y][1].setFormat(null, 10, 0xffffffff, "center", 0);
					this.add(damageArray[x][y][1]);
				}
			}
		}
		
		public function resetDamageArray():void {
			for (var x:int=0; x<mapWidth; x++) {
				for (var y:int=0; y<mapHeight; y++) {
					damageArray[x][y][0] = 0;
					damageArray[x][y][1].text = " ";
				}
			}
		}
		
		public function makeDamageArray():void {
			for (var x:int=0; x<mapWidth; x++) {
				for (var y:int=0; y<mapHeight; y++) {
					if (damageArray[x][y][0] > 4) {
						damageArray[x][y][1].text = "+"+int(damageArray[x][y][0]);
					}
				}
			}
		}
		
		public function initWindAnimation(): void {
			this.wind_animation = new WindSprite(312-155, 240-64);
			this.add(wind_animation);
		}
	
		public function startWindAnimation(direction:int): void {
			this.wind_animation.startAnimation();
			wind_animation.setDirection(direction);
		}
		
		public function stopWindAnimation(): void {
			wind_animation.startEmptyAnimation();
			
		}
	
	}
}