package
{
	public class Wind
	{
		private var energy_level:int;
		private var refresh_rate:int;
		private var use_rate:int;
		
		public function Wind( _energy_level:int, _refresh_rate:int, _use_rate:int)
		{
			this.energy_level = _energy_level;
			this.refresh_rate = _refresh_rate;
			this.use_rate = _use_rate;
		}
		
		public function blow():void
		{
			this.energy_level -= this.use_rate;
		}
		
		public function refresh():void
		{
			this.energy_level += this.refresh_rate;
		}
	}
}