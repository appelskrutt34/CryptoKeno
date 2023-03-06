<script>
    import { activeBet } from "../stores/web3";
    import { web3, account, contract } from "../stores/web3";
    import { ZERO_ADDRESS } from "../helpers/helper";

    const MAX_PICK = 5;
    let numbers = "";
    
    const onNumberPick = (e, i) => {
        if(numbers.includes(i)) {
            numbers = numbers.replace(i,"");
        }
        else if(numbers.length == MAX_PICK) return;
        else {
            numbers += i;
        }
        e.target.classList.toggle("active-number");
    }

    const onMakeABetClick = async() => {
        if(numbers.length != MAX_PICK) return;
        await createBet(numbers);
        resetUi();
    }

    async function createBet(){
        await $contract.methods.createBet(parseInt(numbers)).send({ value: $web3.utils.toWei('0.005', 'ether'), from: $account });
        await setActiveBet();
    }

    const setActiveBet = async () => {
        $activeBet = await $contract.methods.getActiveBet().call({from: $account});
    }

    const resetUi = () => {
        let boxes = document.getElementsByClassName("grid-box");
        for(let i = 0; i < boxes.length; i++){
            boxes[i].classList.remove("active-number");
        }
        numbers = "";
    }
</script>
<div>
    {#if $activeBet[0] == ZERO_ADDRESS}
    <div class="grid">  
        {#each Array(9) as _, i}
            <button class="grid-box" on:click={(e) => {onNumberPick(e, i+1)}}>{i+1}</button>
        {/each}
    </div>
    <div>
        <p class="mt-md">Pick 5 numbers</p>
        <p class="mt-md" style="color: var(--green4); font-weight: 800;">{numbers}</p>
    </div> 
    
    <div class="center-h mt-md">
        <button class="btn btn-green" disabled={numbers.length != MAX_PICK} on:click={onMakeABetClick}><h3>Make bet</h3></button>
    </div>
    {:else}
    <h2 class="mt-md">Active bet</h2>
    <div class="table mt-sm">
        <div class="table-header table-row direction-row">
            <p class="cell">Numbers</p>
        </div>
        <div class="table-row direction-row" style='border: none !important;'>
            <p class="cell">{$activeBet.numbers}</p>
        </div>
    </div>


    {/if}
</div>


<style>
    .grid {
        width: fit-content;
        display: grid;
        grid-template-columns: repeat(3, auto);
        grid-template-rows: repeat(3, auto);
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

    .numbers-grid{
        display: grid;
        grid-template-columns: repeat(5, auto);
    }

</style>