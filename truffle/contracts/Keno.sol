// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

contract Keno {

	struct Bet {
		address payable player;
		uint round;
		string numbers;
	}

	uint constant entry_fee = 0.0001 ether;
	uint round = 0;
	uint draw_count_down = 20;
	uint price_pool = 0;

	Bet[] bets;

	event PricePoolUpdated(uint256 new_price, uint new_draw);
	event drawEnded(string);

	function createBet(string memory numbers) external payable {
	 	require(
            msg.value == entry_fee,
            "Keno: Value does not match entry fee"
        );
		require(draw_count_down >= 1, "can't bet while draw in progress");
		
		draw_count_down--;
		bets.push(Bet(payable(msg.sender), round, numbers));
		price_pool += msg.value;

		emit PricePoolUpdated(price_pool, draw_count_down);

		if(draw_count_down == 0) {
			drawLotteryNumber();
		} 
	}

	function drawLotteryNumber() internal {
		//TODO get random numbers from chainlink https://docs.chain.link/vrf/v2/direct-funding/examples/get-a-random-number
		string memory numbers = "14823";

		emit drawEnded(numbers);
	}

	function getPricePool() external view returns (uint) {
		return price_pool;
	}
	function getDrawCountDown() external view returns (uint) {	
		return draw_count_down;
	}
}
