// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenGamingToken is ERC20, Ownable {
    // Mapping of category token balances
    mapping(address => uint256) public sunTokens;
    mapping(address => uint256) public waterTokens;
    mapping(address => uint256) public windTokens;
    mapping(address => uint256) public moonTokens;

    event Redeem(address indexed from, uint256 value, string category);
    event Burn(address indexed from, uint256 value);
    function decimals() public pure override returns (uint8) {
    return 2; // or any other value you want
}

    constructor(uint256 initialSupply) ERC20("Degen Gaming Token", "DGT") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply * 10**decimals());
    }

    function mint(address to, uint256 value) external onlyOwner {
        require(to!= address(0), "Invalid address");
        _mint(to, value);
    }

    function redeemTokens(uint256 value, string memory category) external {
        require(value <= this.balanceOf(msg.sender), "Insufficient balance");
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
        _burn(msg.sender, value);
        emit Redeem(msg.sender, value, category);
    }

    function playerTransfer(uint256 value, string memory category) public {
    require(value <= this.balanceOf(msg.sender), "Insufficient balance");
    if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("sun"))) {
        sunTokens[msg.sender] += value;
    } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("water"))) {
        waterTokens[msg.sender] += value;
    } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("wind"))) {
        windTokens[msg.sender] += value;
    } else if (keccak256(abi.encodePacked(category)) == keccak256(abi.encodePacked("moon"))) {
        moonTokens[msg.sender] += value;
    }
    _transfer(msg.sender, address(this), value);
    emit Transfer(msg.sender, address(this), value);
}

    function burn(uint256 value) public {
        require(value <= this.balanceOf(msg.sender), "Insufficient balance");
        _burn(msg.sender, value);
        emit Burn(msg.sender, value);
    }

    function checkTokenBalance(address account) public view returns (uint256) {
        return this.balanceOf(account);
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
