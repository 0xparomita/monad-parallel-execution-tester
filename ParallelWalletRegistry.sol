// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
 * @title ParallelWalletRegistry
 * @dev Highly modular architecture structured to demonstrate parallel execution boundaries.
 */
contract ParallelWalletRegistry {
    // Isolated user mappings that reside on completely distinct storage slots
    mapping(address => uint256) public userBalances;
    mapping(address => string) public userProfiles;

    event BalanceUpdated(address indexed user, uint256 newBalance);
    event ProfileUpdated(address indexed user, string newProfile);

    /**
     * @notice Updates isolated values. Executing this function for User A and User B simultaneously
     * triggers completely parallel state transitions on Monad without creating sequential blocks.
     */
    function updateUserData(uint256 balanceIncrement, string calldata profileIpfsHash) external {
        userBalances[msg.sender] += balanceIncrement;
        userProfiles[msg.sender] = profileIpfsHash;

        emit BalanceUpdated(msg.sender, userBalances[msg.sender]);
        emit ProfileUpdated(msg.sender, profileIpfsHash);
    }
}
