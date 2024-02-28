async function enter() {
  let instance = await Lottery.deployed();
  await instance.enterLottery({from: accounts[0], value: web3.utils.toWei("0.1", "ether")});
  let balance = await web3.eth.getBalance(instance.address);
  console.log("Contract balance:", web3.utils.fromWei(balance, "ether"), "ETH");
}
enter();