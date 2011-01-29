package
{
	public class BurningStuff
	{
		private var type:String = "";
		private var burn_threshold:int = 0;
		private var burn_duration:int = 0;
		private var burn_energy:int = 0;
		
		private var fire_animation:FireSprite;
		private var smoke_animation:SmokeSprite;
		
		private var neighbours_up:Boolean;
		private var neighbours_right:Boolean;
		private var neighbours_down:Boolean;
		private var neighbours_left:Boolean;
		
		public var neighbourhood_value:int;
		
		// we have 4 states of 'burning'
		// 0 = normal
		// 1 = scorching (anbrennen)
		// 2 = burning
		// 3 = burnt
		private var burn_state:int = 0;
		
		private var tile_position_x:int;
		private var tile_position_y:int;
		
		public function BurningStuff(_type:String, _burn_threshold:int, _burn_duration:int, _burn_energy:int)
		{
			this.type = _type;
			this.burn_threshold = _burn_threshold; 
			this.burn_duration = _burn_duration;
			this.burn_energy = _burn_energy;
			
			this.burn_state = 0;
			
			this.neighbours_up = true;
			this.neighbours_right = true;
			this.neighbours_down = true;
			this.neighbours_left = true;
		}
		
		public function setTileX(_x:int):void
		{
			this.tile_position_x = _x;
		}
		
		public function getTileX(_x:int):int
		{
			return tile_position_x;
		}
		
		public function setTileY(_y:int):void
		{
			this.tile_position_y = _y;
		}
		
		public function getTileY(_x:int):int
		{
			return tile_position_y;
		}
		
		public function setNeighboursUp(_up:Boolean ):void
		{
			this.neighbours_up = _up;
		}
		
		public function getNeighboursUp( ):Boolean
		{
			return neighbours_up;
		}
		
		public function setNeighboursRight(_right:Boolean ):void
		{
			this.neighbours_right = _right;
		}
		
		public function getNeighboursRight( ):Boolean
		{
			return neighbours_right;
		}
		
		public function setNeighboursDown(_down:Boolean ):void
		{
			this.neighbours_down = _down;
		}
		
		public function getNeighboursDown( ):Boolean
		{
			return neighbours_down;
		}
		
		public function setNeighboursLeft(_left:Boolean ):void
		{
			this.neighbours_left = _left;
		}
		
		public function getNeighboursLeft( ):Boolean
		{
			return neighbours_left;
		}
		
		// returns 0, if neighbours everywhere
		// returns 1, if neighbours on the top
		public function checkNeighbours():void
		{
			if (this.neighbours_up && this.neighbours_right && this.neighbours_down && this.neighbours_left)
				this.neighbourhood_value = 0;
			else if ((this.neighbours_up == false || this.neighbours_down == false) && this.neighbours_left == true && this.neighbours_right == true)
				this.neighbourhood_value = 1;
			else if ((this.neighbours_left == false || this.neighbours_right == false ) && this.neighbours_up == true && this.neighbours_down == true)
				this.neighbourhood_value = 2;
			else 
				this.neighbourhood_value = 3;
		}
		// todo: "neighbourhoodvalue" als variable 
		
		public function getNeighbourhoodValue():int
		{
			return this.neighbourhood_value;
		}
		
		public function setOnFire():void
		{
			if (this.burn_threshold > 0)
				this.burn_threshold = 0;
			this.burn_state = 2;
		}
		
		public function setScorching():void
		{
			this.burn_state = 1;
		}
		
		public function setBurnt():void 
		{
			this.burn_state = 3;
		}
		
		public function isBurning():Boolean
		{
			if (this.burn_state == 2)
				return true;
			else
				return false;
		}
		
		public function isBurnt():Boolean
		{
			if (this.burn_state == 3 )
				return true;
			else
				return false;
		}
		
		public function isScorching():Boolean
		{
			if (this.burn_state == 1)
			{	
				return true;
			}
			else
			{	
				return false;
			}
		}
		
		// returns false if threshhold has reached zero
		public function decreaseThreshold(value:int):Boolean
		{
			if (!this.isScorching())
				this.setScorching();	
			
			this.burn_threshold -= value; 
	
			if (this.burn_threshold <= 0)
			{
				this.setOnFire();
				return false;
			}
			else
			{
				return true;
			}
		}
		
		// returns false if objects has burned out
		public function decreaseDuration(value:int):Boolean
		{
			this.burn_duration -= value;
	
			if (this.burn_duration <= 0)
			{
				this.setBurnt();
				return false;
			}
			else
			{
				return true;
			}
		}
		
		public function setFireAnimation(_fire_animation: FireSprite):void
		{
			this.fire_animation = _fire_animation;
		}
		
		public function killFireAnimation():void
		{
			this.fire_animation.kill();
		}
		
		public function setSmokeAnimation(_smoke_animation: SmokeSprite):void
		{
			this.smoke_animation = _smoke_animation;
		}
		
		public function killSmokeAnimation(): void
		{
			this.smoke_animation.kill();
		}
	}
}