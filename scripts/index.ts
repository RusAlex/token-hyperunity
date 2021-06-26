let fs = require("fs");
let startFrom;
let started = 0;
module.exports = async function main(callback) {
  try {
    let sum = 0;
    let toSend = fs
      .readFileSync("./scripts/holders.csv")
      .toString()
      .split("\r\n")
      .map((x, i) => {
        if (i < 2) {
          return;
        }
        const [address, amount] = x.replace(/"/g, "").split(",");
        if (!Number.isNaN(Number(amount))) {
          sum += Number(amount);
        }
        if (!startFrom) {
          started = 1;
        }

        if (startFrom && address === startFrom) {
          started = 1;
        }
        if (started) {
          return [address, amount];
        }
      })
      .filter(x => !!x && x[0]);
    console.log(sum);
    // get current amount devide it by existing sum
    // multiply it to 200,000,000

    const accounts = await web3.eth.getAccounts();
    const Token = artifacts.require("Token");
    const token = await Token.deployed();
    // // Send a transaction to store() a new value in the Box
    for (let i = 0; i < toSend.length && i < 100; i++) {
      const item = toSend[i];

      const newAmount = ((Number(item[1]) / sum) * 20000000).toFixed(0);
      if (newAmount === "0") {
        continue;
      }
      try {
        await token.mint(item[0], newAmount, {
          from: accounts[0]
        });
      } catch (error) {
        console.log(item, error);
        throw error;
      }
    }
    callback(0);
  } catch (error) {
    console.error(error);
    callback(1);
  }
};
