contract A {
	uint256 public value;

	/// A message that can be called on instantiated contracts.
	/// This one flips the value of the stored `bool` from `true`
	/// to `false` and vice versa.
	function inc(uint256 _v) public {
		value += _v;
	}

	/// Simply returns the current value of our `bool`.
	function get() public view returns (uint256) {
		return value;
	}
}

contract flipper {
	A public a;

	function test(address _a) public returns (uint256) {
		return 1;
	}

	function setA(address _a) public {
		a = A(_a);
	}

	/// A message that can be called on instantiated contracts.
	/// This one flips the value of the stored `bool` from `true`
	/// to `false` and vice versa.
	function inc(uint256 _v) public {
		a.inc(_v);
	}

	/// Simply returns the current value of our `bool`.
	function get() public view returns (uint256) {
		return a.get();
	}
}
