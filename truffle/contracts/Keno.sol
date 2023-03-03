// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Keno {

	struct Player {
		address payable better;
		string numbers;
	}

	uint participation_fee = 50000;
	uint price_sum;
	Player[] players;

	function createBet(string memory numbers) external payable {
	 require(
            msg.value == participation_fee,
            "Keno: Value does not match participation fee"
        );

		players.push(Player(payable(msg.sender), numbers));
		price_sum += msg.value;
	}

	function getPriceSum() external view returns (uint) {
		return price_sum;
	}

	function getPlayers() external view returns (Player[] memory) {
		return players;
	}
}
