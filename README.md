# DEGEN GAMING TOKEN
This is a smart contract in the form of a token for Degen Gaming, where several functionalities can be performed.

## Description
With the help of this smart contract, we can mint tokens, transfer them from one address to another, burn them, and also redeem merchandise from Degen Gaming over a decentralized network. The working of the contract is verified on the Avalanche Fuji Test Network, and the verification is done on Snowtrace Testnet.

## Getting Started
### Installing
You can download the DegenGamingToken.sol file and then compile it in Remix. Choose the Environment as Injected Provider - Metamask and deploy the contract.

### Executing program

Follow these steps to deploy and verify the contract:

1. Configure Metamask for Avalanche Fuji C-Chain:
   - **Network Name**: Avalanche Fuji C-Chain
   - **New RPC URL**: https://api.avax-test.network/ext/bc/C/rpc
   - **ChainID**: 43113
   - **Symbol**: AVAX
   - **Explorer**: https://testnet.snowtrace.io/

2. Obtain test AVAX tokens through the Avalanche faucet or testing avenues provided by Avalanche.

3. Deploy the compiled `DegenToken.sol` contract using Remix with Metamask injected provider.

4. Flatten the solidity file and download the flattened file.

5. Verify the contract on Snowtrace Testnet:
   - Paste the deployed contract address.
   - Choose Avalanche Fuji as the chain.
   - Select the compiler version specified in the solidity file.
   - Upload the flattened solidity file and verify.
     
## Working
After the contract is deployed, you can perform the following operations in it:

1. **Minting Tokens**: Only the contract owner can mint new tokens.
2. **Transferring Tokens**: Users can transfer tokens to other addresses.
3. **Approving Spending**: Users can approve other addresses to spend tokens on their behalf.
4. **Redeeming Tokens**: Tokens can be redeemed for specific categories (sun, water, wind, moon) based on predefined token balances for each category.
5. **Burning Tokens**: Users can burn their tokens, increasing the balance of specific category tokens.
6. **Checking Balances**: Users can check their token balance and category-specific token balances.


## Help
If you encounter any issues while interacting with the contract, ensure that your environment is configured correctly with the necessary Ethereum network or testnet. Verify the Solidity compiler version compatibility and contract deployment details.

## Authors

Aditi Rajput
[@Chandigarh University](https://www.linkedin.com/in/aditi-rajput-b9360720b/)


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
