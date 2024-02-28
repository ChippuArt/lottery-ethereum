// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.21;

contract Lottery {

  address contractOwner;

  constructor(){
    contractOwner = msg.sender;
  }

  uint256 lotteryFee = 0.001 ether;
  uint creatorFee = 0.08 ether;

  struct LotteryRound {
    address owner;
    address [] players;
    uint256 pricePool;
    uint256 storePricePool;
    bool isActive;
    bool contractOwnerfeePayed;
    bool creatorFeePayed;
    address winner;
  }

  event LotteryStarted(uint256 indexed lotteryId);
  event LotteryJoined(uint256 indexed lotteryId, address player);
  event WinnerPicked(uint256 indexed lotteryId, address winner);


  uint256 lotteryIndex = 1;
  mapping (uint256 => LotteryRound) lotteries;

   modifier onlyWhileActive(uint256 lotteryId) {
        require(lotteries[lotteryId].isActive == true, "Lottery round is not active.");
        _;
    }
  
  function random(uint256 lotteryId) private view onlyWhileActive(lotteryId) returns (uint) {
    return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, lotteries[lotteryId].players)));
  }

  function startLottery() public payable {
    require(msg.value == lotteryFee, "To create a lottery you' ll need to pay a minimum fee of 0.001 ether.");
    LotteryRound storage newLottery = lotteries[lotteryIndex];
    bool sent = payable(contractOwner).send(msg.value);
    require(sent, "Failed to send Ether");
    newLottery.contractOwnerfeePayed = true;
    newLottery.isActive = true;
    newLottery.owner = msg.sender;
    emit LotteryStarted(lotteryIndex);
    lotteryIndex++;
  }

  function viewPlayers(uint256 lotteryId) public view returns(address[] memory){
    return lotteries[lotteryId].players;
  }

  function viewPricePool(uint256 lotteryId) public view returns(uint256){
    return lotteries[lotteryId].storePricePool;
  }

  function viewLotteryCreator(uint256 lotteryId)public view returns(address){
    return lotteries[lotteryId].owner;
  }

  function viewWinner(uint256 lotteryId)public view returns(address){
    return lotteries[lotteryId].winner;
  }

  function buyLotteryTicket(uint256 lotteryId) public payable onlyWhileActive(lotteryId) {
    require(msg.value == 0.1 ether, "The lottery ticket costs 0.1 Ether. Please transfer exactly 0.1 Ether to participate in the lottery!");
    lotteries[lotteryId].players.push(msg.sender);
    lotteries[lotteryId].pricePool += msg.value;
    lotteries[lotteryId].storePricePool += uint256(msg.value);
    emit LotteryJoined(lotteryId, msg.sender);
  }

function pickWinner(uint256 lotteryId) public onlyWhileActive(lotteryId){
    require(lotteries[lotteryId].owner == msg.sender, "You have no permission to pick the winner.");
      uint index = random(lotteryId) % lotteries[lotteryId].players.length;
      uint price = lotteries[lotteryId].pricePool- creatorFee;
     (bool feeTransferSuccess,) = payable(lotteries[lotteryId].owner).call{value: creatorFee}("");
      require(feeTransferSuccess, "Failed to send CreatorFee.");
      lotteries[lotteryId].creatorFeePayed = true;
      address winner = lotteries[lotteryId].players[index];
      lotteries[lotteryId].winner = winner;
      (bool prizeTransferSuccess,) = payable(winner).call{value: price}("");
      require(prizeTransferSuccess, "Failed to send PricePool to Winner.");
      lotteries[lotteryId].pricePool -= (price + creatorFee);
      require(lotteries[lotteryId].pricePool == 0, "Prize pool must be distributed before deactivating.");
      lotteries[lotteryId].isActive = false;
      emit WinnerPicked(lotteryId, winner);     
  }
}