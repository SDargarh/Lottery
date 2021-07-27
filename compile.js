const path = require('path');
const fs = require('fs');
const solc = require('solc');

const lotteryPath = path.resolve(__dirname, 'contracts', 'Lottery.sol');
const source = fs.readFileSync(lotteryPath, 'utf8');

var input = {
    language: 'Solidity',
    sources: {
        'Lottery.sol' : {
            content: source
        }
    },
    settings: {
        outputSelection: {
            '*': {
                '*': [ '*' ]
            }
        }
    }
}; 

output = JSON.parse(solc.compile(JSON.stringify(input)));
abi = output.contracts["Lottery.sol"]["Lottery"].abi;
bytecode = output.contracts["Lottery.sol"]["Lottery"].evm.bytecode.object;

module.exports = {abi, bytecode}