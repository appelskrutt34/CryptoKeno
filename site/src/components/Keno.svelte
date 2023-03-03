<script>
    import { contract, web3 } from "../stores/web3";

    let chosenNumbers = [];
    const MAX_PICK = 10;

    const onNumberPick = (e, i) => {
        if(chosenNumbers.includes(i)) {
            chosenNumbers = chosenNumbers.filter(number => number != i);
        }
        else if(chosenNumbers.length == MAX_PICK) return;
        else {
            chosenNumbers.push(i);
        }

        let btn = e.target;
        btn.classList.toggle("active-number");
    }

    const onMakeABetClick = async() => {
        let numbers = chosenNumbers.join('');
        console.log(numbers);
        if(!containsOnlyNumbers(numbers) || chosenNumbers.length != MAX_PICK) return;
        console.log("try");
        try {
            await $contract.methods.createBet(numbers).send({ value: 50000 });
            let pricePool = await $contract.methods.getPriceSum().call();
            console.log("price pool: " + pricePool); 
        } catch (error) {
            console.error(error);
        }
    }

    const containsOnlyNumbers = (str) => {
        return /^\d+$/.test(str);
    }

</script>

<div>
    <div class="grid">  
        {#each Array(25) as _, i}
            <button class="grid-box" on:click={(e) => {onNumberPick(e, i)}}>{i}</button>
        {/each}
    </div>
    <div class="center-h mt-md">
        <button class="btn btn-green" on:click={onMakeABetClick}>Make a bet</button>
    </div>
    
</div>


<style>
    .grid {
        width: fit-content;
        display: grid;
        grid-template-columns: repeat(5, auto);
        grid-template-rows: repeat(5, auto);
        gap: .5rem;
    }
    .grid-box {
        color: white;
        background-color: transparent;
        width: 4rem;
        height: 4rem;
        border-radius: 1rem;
        border: 1px solid var(--lightgray);
    }
    .grid-box:hover {
        cursor: pointer;
        background-color: var(--green4);
    }

</style>