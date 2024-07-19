// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract ElementalToken is ERC20, Ownable, ERC20Burnable {

    event TokensRedeemed(address indexed redeemer, uint256 amount, string reward);
    event HomageClanEarned(address indexed player, uint256 amount, string badge);

    mapping(address => string[]) public inventory;

    constructor() ERC20("Elemental", "ELM") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        burn(_value);
    }

    function getBalance() external view returns (uint256) {
    return balanceOf(msg.sender);
}

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        require(balanceOf(msg.sender) >= amount, "ERC20: transfer amount exceeds balance");
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        require(balanceOf(sender) >= amount, "ERC20: transfer amount exceeds balance");
        uint256 currentAllowance = allowance(sender, msg.sender);
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        unchecked {
            _approve(sender, msg.sender, currentAllowance - amount);
        }
        _transfer(sender, recipient, amount);
        return true;
    }

    function redeemTokens(address _redeemer, uint256 _amount) external {
        require(balanceOf(_redeemer) >= _amount, "The specified address does not have enough Elemental Tokens to redeem this reward");

        string memory reward;
        if (_amount == 300) {
            reward = "Earth Elemental Box";
        } else if (_amount == 200) {
            reward = "Water Elemental Box";
        } else if (_amount == 100) {
            reward = "Wind Elemental Box";
        } else if (_amount == 50) {
            reward = "Fire Elemental Box";
        } else {
            revert("Not enough tokens for any reward");
        }

        _burn(_redeemer, _amount);
        inventory[_redeemer].push(reward);
        emit TokensRedeemed(_redeemer, _amount, reward);
    }

    function earnHomageClan(address _player, uint256 _amount) external {
        require(balanceOf(_player) >= _amount, "The specified address does not have enough Elemental Tokens to earn this badge");

        string memory clan;
        if (_amount == 80) {
            clan = "Earth Elemental Clan";
        } else if (_amount == 60) {
            clan = "Water Elemental Clan";
        } else if (_amount == 40) {
            clan = "Wind Elemental Clan";
        } else if (_amount == 20) {
            clan = "Fire Elemental Clan";
        } else {
            revert("Not enough tokens for any Clan");
        }

        _burn(_player, _amount);
        inventory[_player].push(clan);
        emit HomageClanEarned(_player, _amount, clan);
    }

    function getInventory(address _owner) external view returns (string[] memory) {
        return inventory[_owner];
    }

    function redeemRules() external pure returns (string memory) {
        return "Homage Clan:\n"
               "20 ELM - Fire Elemental Clan\n"
               "40 ELM - Wind Elemental Clan\n"
               "60 ELM - Water Elemental Clan\n"
               "80 ELM - Earth Elemental Clan\n\n"
               "Elemental Kingdom:\n"
               "50 ELM - Fire Elemental Box\n"
               "100 ELM - Wind Elemental Box\n"
               "200 ELM - Water Elemental Box\n"
               "300 ELM - Earth Elemental Box";
    }
}
