pragma solidity ^0.8.0;

// SPDX-License-Identifier: UNLICENSED

contract DegenGamingToken {
    string public name = "Degen Gaming Token";
    string public symbol = "DGT";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Redeem(address indexed from, uint256 value, string category);

    uint256 public participationFee = 100; // Number of tokens required to participate in the ring game
    uint256 public bonusTokens = 500; // Number of bonus tokens the winner receives

    // The address of the current winner of the ring game
    address public currentWinner;
    // Flag to determine if a game is currently in progress
    bool public gameInProgress;

    // Event to announce the winner of the ring game
    event WinnerAnnounced(address indexed winner, uint256 bonusTokens);

    // Mapping of category token balances
    mapping(address => uint256) public sunTokens;
    mapping(address => uint256) public waterTokens;
    mapping(address => uint256) public windTokens;
    mapping(address => uint256) public moonTokens;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10**uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function mint(address to, uint256 value) public onlyOwner {
        require(to!= address(0), "Invalid address");
        totalSupply += value;
        balanceOf[to] += value;
        emit Mint(to, value);
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(to!= address(0), "Invalid address");
        require(value <= balanceOf[msg.sender], "Insufficient balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function redeemTokens(uint256 value, string memory category) public {
        require(value <= balanceOf[msg.sender], "Insufficient balance");
        if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("sun"))) {
            require(sunTokens[msg.sender] >= 2000, "Not enough moon tokens to redeem sun token");
            sunTokens[msg.sender] -= 2000;
        } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("water"))) {
            require(waterTokens[msg.sender] >= 1500, "Not enough wind tokens to redeem water token");
            waterTokens[msg.sender] -= 1500;
        } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("wind"))) {
            require(windTokens[msg.sender] >= 1000, "Not enough sun tokens to redeem wind token");
            windTokens[msg.sender] -= 1000;
        } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("moon"))) {
            require(moonTokens[msg.sender] >= 800, "Not enough water tokens to redeem moon token");
            moonTokens[msg.sender] -= 800;
        }
        balanceOf[msg.sender] -= value;
        emit Redeem(msg.sender, value, category);
    }

    function burnTokens(uint256 value, string memory category) public {
        require(value <= balanceOf[msg.sender], "Insufficient balance");
        if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("sun"))) {
            sunTokens[msg.sender] += value;
        } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("water"))) {
            waterTokens[msg.sender] += value;
        } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("wind"))) {
            windTokens[msg.sender] += value;
        } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("moon"))) {
            moonTokens[msg.sender] += value;
        }
        balanceOf[msg.sender] -= value;
        emit Burn(msg.sender, value); // Corrected here
    }

    function checkBalance(address account) public view returns (uint256) {
        return balanceOf[account];
    }

    function checkCategoryBalance(address account, string memory category) public view returns (uint256) {
        if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("sun"))) {
            return sunTokens[account];
        } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("water"))) {
            return waterTokens[account];
        } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("wind"))) {
            return windTokens[account];
        } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("moon"))) {
            return moonTokens[account];
        }
        return 0;
    }
}
