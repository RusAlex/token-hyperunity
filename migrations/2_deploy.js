const Token = artifacts.require("Token");

module.exports = async function(deployer) {
    await deployer.deploy(Token);
};
