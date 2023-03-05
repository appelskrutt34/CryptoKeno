<script>
    import { contract,web3 } from "../stores/web3";

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

        try {
            await $contract.methods.createBet(parseInt(numbers)).send({ value: $web3.utils.toWei('0.0001', 'ether') });
        } catch (error) {
            console.error(error);
        }

        resetUi();
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
    <div class="grid">  
        {#each Array(9) as _, i}
            <button class="grid-box" on:click={(e) => {onNumberPick(e, i+1)}}>{i+1}</button>
        {/each}
    </div>
    <p class="mt-md">{numbers}</p>
    <div class="center-h mt-md">
        <button class="btn btn-green" disabled={numbers.length != MAX_PICK} on:click={onMakeABetClick}><h2>Make bet</h2></button>
    </div>
    
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

</style>