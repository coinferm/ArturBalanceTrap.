// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface IArturTrap {
    function collect() external returns (bytes memory);
    function shouldRespond(bytes[] calldata data) external view returns (bool, bytes memory);
}

contract ArturBalanceTrap is IArturTrap {
    address public constant monitoredWallet = 0x11c5c06a4EBa3401d635a94883BcF58463BeBAcF; // adress
    uint256 public constant thresholdPercent = 1;

    function collect() external override returns (bytes memory) {
        return abi.encode(monitoredWallet.balance);
    }

    function shouldRespond(bytes[] calldata data) external view override returns (bool, bytes memory) {
        if (data.length < 2) return (false, "Insufficient data");

        uint256 current = abi.decode(data[0], (uint256));
        uint256 previous = abi.decode(data[1], (uint256));

        uint256 diff = current > previous ? current - previous : previous - current;
        uint256 percent = (diff * 100) / previous;

        if (percent >= thresholdPercent) {
            return (true, "");
        }

        return (false, "");
    }
}
