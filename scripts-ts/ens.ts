import { ethers } from 'ethers'

import InfoRetrievalTestOut from '../out/InfoRetrievalTest.sol/InfoRetrievalTest.json';

// To connect to a custom URL:
// Sepolia: https://eth-sepolia.public.blastapi.io
// NeonEVM Devnet: https://devnet.neonevm.org
const url = "https://eth-sepolia.public.blastapi.io";
const provider = new ethers.providers.JsonRpcProvider(url);
const wallet = ethers.Wallet.createRandom().connect(provider)
const InfoRetrievalTestFactory = new ethers.ContractFactory(InfoRetrievalTestOut.abi, InfoRetrievalTestOut.bytecode, wallet)


const main = async () => {
    // Obtain the bytecode needed tp deploy contract

    const { data } = InfoRetrievalTestFactory.getDeployTransaction(4);

    // `eth_call`
    const retDataE = await provider.call({ data })

    console.log(`Return Data: ${retDataE}`);

    // If you're going to change the return value you'll need to change the encoding here
    /*
    Return is of type:

    address[] memory
    */

    // Format it back
    const dummyData: string[] = ethers.utils.defaultAbiCoder.decode(["address[]"], retDataE)[0]

    dummyData.forEach((x) => {
        console.log(`${x}`)
    })
}

main()