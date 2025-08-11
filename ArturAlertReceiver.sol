// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ArturAlertReceiver {
    event Alert(string message);

    function logAnomaly(string calldata message) external {
        emit Alert(message);
    }
}
