contract A {
	uint256 public value;

	constructor() payable {
		
	}

	/// Simply returns the current value of our `bool`.
	function set() public payable {
		value = msg.value;
	}
}

contract flipper {
	A public a;

	function setA() public payable {
		a = new A{value: msg.value, salt: keccak256("hell")}();
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
