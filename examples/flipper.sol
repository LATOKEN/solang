contract A {
	uint256 public value;

	/// Simply returns the current value of our `bool`.
	function set() public payable {
		value = msg.value;
	}
}

contract flipper {
	A public a;

	function setA(address _a) public {
		a = A(_a);
	}

	/// A message that can be called on instantiated contracts.
	/// This one flips the value of the stored `bool` from `true`
	/// to `false` and vice versa.
	function set() public payable {
		a.set{value: msg.value}();
	}

	/// Simply returns the current value of our `bool`.
	function value() public view returns (uint256) {
		return a.value();
	}
}
