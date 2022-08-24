contract AllFeatures {
    uint public value;

    string public str;

    mapping(uint256 => bytes32) public map;

    /**
     * @dev Recover signer address from a message by using their signature
     * @param hash bytes32 message, the hash is the signed message. What is recovered is the signer address.
     * @param signature bytes signature, the signature is generated using web3.eth.sign()
     */
    function recover(bytes32 hash, bytes memory signature) public pure returns (address) {
        // Divide the signature in r, s and v variables
        bytes32 r;
        bytes32 s;
        uint32 v;

        bytes memory rA = new bytes(32);
        bytes memory sA = new bytes(32);

        for (uint256 i = 0; i < 32; i += 1) {
            rA[i] = signature[i];
            sA[i] = signature[i + 32];
        }

        r = bytes32(rA);
        s = bytes32(sA);
        
        if (signature.length == 65) {
            v = uint8(signature[65]);
        } else {
            v = uint8(signature[64]) * 256 + uint8(signature[65]);
        }

        // If the signature is valid (and not malleable), return the signer address
        return ecrecover(hash, v, r, s);
    }

    function createMesssageHash(uint256 amount, address recipient, bytes8 chainId) public pure returns (bytes32) {
        bytes memory _message = abi.encode(amount, recipient, chainId);
        bytes32 msgHash = keccak256(_message);
        return msgHash;
    }

    function testEcrecover(uint256 amount, address recipient, bytes8 chainId, bytes memory signature) public pure returns (address) {
        return recover(createMesssageHash(amount, recipient, chainId), signature);
    }

    function testExtcodesize(address _a) public view returns (uint) {
        uint len;

        assembly {
            len := extcodesize(_a)
        }

        return len;
    }

    function testString(string calldata _str) public {
        str = _str;
    }

    function testMap(uint256 k, string calldata v) public {
        map[0] = keccak256(abi.encode("Hello"));
        map[k] = keccak256(abi.encode(v));
    }

    function testMulmod() public pure returns (uint256)
    {
        return mulmod(0x000000000000000000000000000000000000000000000000000000000000000a, 0x00000000000000000000000000000000000000000000000000000000000f3688,  ~uint256(0));
    }

    function testHash() public pure returns (bytes20) {
        return ripemd160("ss");
    }

    function testMsgSender() public view returns (address) {
        return msg.sender;
    }

    function testBalance() public payable returns (uint256) {
        value = address(this).balance;

        return address(this).balance;
    }

    function testAddressThis() public view returns (address) {
        return address(this);
    }

    function testMsgValue() public payable returns (uint256) {
        value = msg.value;

        return msg.value;
    }

    function testMsgSig() public pure returns (bytes4) {
        return msg.sig;
    }
    
    function testGas() public view returns (uint256) {
        return gasleft();
    }

    function testTxGasprice() public view returns (uint256) {
        return tx.gasprice;
    }

    function testTxOrigin() public view returns (address) {
        return tx.origin;
    }

    function testBlockChainId() public view returns (uint) {
        return block.chainid;
    }

    function testBlockCoinbase() public view returns (address) {
        return block.coinbase;
    }

    function testBlockGaslimit () public view returns (uint256) {
        return block.gaslimit;
    }

    function testBlockNumber () public view returns (uint256) {
        return block.number;
    }

    function testBlockDifficulty() public view returns (uint256) {
        return block.difficulty;
    }

    function testBalance(address a) public view returns (uint256) {
        return a.balance;
    }

    function testBlockTimestampy() public view returns (uint256) {
        return block.timestamp;
    }
}
