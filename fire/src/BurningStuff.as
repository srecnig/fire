package
{
	public class BurningStuff
	{
		private var type:String = "";
		private var burn_threshold:int = 0;
		private var burn_duration:int = 0;
		private var burn_energy:int = 0;
		
		// we have 4 states of 'burning'
		// 0 = normal
		// 1 = scorching (anbrennen)
		// 2 = burning
		// 3 = burnt
		private var burn_state:int = 0;
		
		//public tile_position_x;
		//public tile_position_y;
		
		public function BurningStuff(_type:String, _burn_threshold:int, _burn_duration:int, _burn_energy:int)
		{
			this.type = _type;
			this.burn_threshold = _burn_threshold; 
			this.burn_duration = _burn_duration;
			this.burn_energy = _burn_energy;
			
			this.burn_state = 0;
		}
		
		public function setOnFire():void
		{
			if (this.burn_threshold > 0)
				this.burn_threshold = 0;
			this.burn_state = 1;
		}
		
		public function setScorching():void
		{
			this.burn_state = 1;
		}
		
		public function setBurnt():void 
		{
			this.burn_state = 2;
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
			if (this.burn_state == 4 )
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
	}
}