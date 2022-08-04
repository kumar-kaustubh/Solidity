//SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;
import"https://github.com/OpenZeppelin/openzeppelin-contracts/blob/3dac7bbed7b4c0dbf504180c33e8ed8e350b93eb/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/b0cf6fbb7a70f31527f36579ad644e1cf12fdf4e/contracts/mocks/SafeMathMock.sol";
contract Allowance is Ownable {
 
 using SafeMath for uint;
event AllowanceChanged(address indexed _forWho, address indexed _byWhom, uint _oldAmount, uint _newAmount);
 mapping(address => uint) public allowance;
 
 
 function setAllowance(address _who, uint _amount) public onlyOwner {
 emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
 allowance[_who] = _amount;
 }
 
 modifier ownerOrAllowed(uint _amount) {
     require(msg.sender == owner() || allowance[msg.sender] >= _amount, "You are not allowed!");
     _;
 }
 function reduceAllowance(address _who, uint _amount) internal ownerOrAllowed(_amount) {
 emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
 allowance[_who] = allowance[_who].sub(_amount);
 }
 function renounceOwnership() public override onlyOwner {
 revert("can't renounceOwnership here"); //not possible with this smart contract
 }
 
}
