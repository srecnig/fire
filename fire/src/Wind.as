package
{
	public class Wind
	{
		private energy_level:Int;
		private refresh_rate:Int;
		private use_rate:Int;
		
		public function Wind(_energy_level:Int, _refresh_rate:Int, _use_rate:Int)
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