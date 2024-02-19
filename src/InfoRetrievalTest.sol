pragma solidity 0.8.21;
pragma experimental ABIEncoderV2;

import "./DummyInformation.sol";

contract InfoRetrievalTest {
    // Replace the DummyInformation contract address based on the network you would want to try against
    // Deployments of DummyInformation contracts:
    // Sepolia: 0x285468AC2C6d432EAF7Bc338d7b429E6cfBa4736
    // NeonEVM Devnet: 0x49b94D676a728FeF662ca4087307A7C6de27fe46
    DummyInformation private constant dummyInformation =
        DummyInformation(0x285468AC2C6d432EAF7Bc338d7b429E6cfBa4736);

    constructor(uint recordsCount) {
        address[] memory r = new address[](recordsCount);
        for (uint256 i = 0; i < recordsCount; i++) {
            r[i] = dummyInformation.information(i);
        }

        // insure abi encoding, not needed here but increase reusability for different return types
        // note: abi.encode add a first 32 bytes word with the address of the original data
        bytes memory _abiEncodedData = abi.encode(r);

        assembly {
            // Return from the start of the data (discarding the original data address)
            // up to the end of the memory used
            let dataStart := add(_abiEncodedData, 0x20)
            return(dataStart, sub(msize(), dataStart))
        }
    }
}
