// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

contract Keno {

	struct Bet {
		address payable player;
		uint numbers;
	}

	struct Winner {
		address payable player;
		uint date;
		uint price;
		uint numbers;
	}

	address payable owner;
	uint64 constant entry_fee = 0.001 ether;
	uint64 constant chainlink_fee = 0.0003 ether;
	uint8 draw_count_down = 2;
	uint price_pool = 0;

	Bet[] bets;
	Winner[] winners;

	event pricePoolUpdated(uint new_price, uint8 new_draw);
	event drawEnded(uint numbers, uint winner_count);

	constructor() {
		owner = payable(msg.sender);
	}

	function createBet(uint numbers) external payable {
	 	require(
            msg.value == entry_fee,
            "Value does not match entry fee"
        );
		require(draw_count_down >= 1, "Can't bet while draw in progress");
		
		draw_count_down--;
		bets.push(Bet(payable(msg.sender), numbers));
		price_pool += (msg.value - chainlink_fee);

		emit pricePoolUpdated(price_pool, draw_count_down);

		if(draw_count_down == 0) {
			drawLotteryNumber();
		}
	}

	function drawLotteryNumber() private {
		//TODO get random numbers from chainlink https://docs.chain.link/vrf/v2/direct-funding/examples/get-a-random-number

		uint numbers = 14823;
		uint winner_count = 0;

		for (uint i = 0; i < bets.length; i++) { 
			if(bets[i].numbers == numbers) {
				winner_count++;
			}
      	}

		if(winner_count > 0) {
			uint date = block.timestamp;
			uint price_per_winner = price_pool / winner_count;
			price_pool = 0;

			for (uint i = 0; i < bets.length; i++) { 
				if(bets[i].numbers == numbers) {
					bets[i].player.transfer(price_per_winner);
					winners.push(Winner({player: bets[i].player, date: date, price: price_per_winner, numbers: numbers}));
				}
      		}
		}

		delete bets;
		draw_count_down = 2;

		emit drawEnded(numbers, winner_count);
	}

	function getWinners() external view returns (Winner[] memory) {
		return winners;
	}
	function getPricePool() external view returns (uint) {
		return price_pool;
	}
	function getDrawCountDown() external view returns (uint) {	
		return draw_count_down;
	}

	function deposit () external payable {}

	function withdraw(uint256 amount) external payable {
		require(msg.sender == owner, "Not owner of contract");
		require(address(this).balance >= amount, "Not enough balance");

		owner.transfer(amount);
	}

	function isOwner() external view returns(bool){
		return msg.sender == owner;
	}

	receive() external payable {}
    fallback() external payable {}
}
