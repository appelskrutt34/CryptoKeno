<script>
    import { onMount } from "svelte";
    import { contract,web3 } from "../../stores/web3";
    import { goto } from '$app/navigation';
     
    let deposit;
    let withdraw;
    let entryFee;
    let chainlinkFee;

    onMount(async() => {
        let owner = await $contract.methods.isOwner().call();
        if(owner == false){
            goto(`/`, { replaceState }) 
        }
    })

    const depositEth = async() => {
        await $contract.methods.deposit().send({value: $web3.utils.toWei(deposit, 'ether')});
    }

    const withdrawEth = async () => {
        await $contract.methods.withdraw($web3.utils.toWei(withdraw, 'ether')).send();
    }

    const changeEntryFee = async () => {
        await $contract.methods.withdraw($web3.utils.toWei(withdraw, 'ether')).send();
    }

    const changeChainlinkFee = async () => {
        await $contract.methods.withdraw($web3.utils.toWei(withdraw, 'ether')).send();
    }
</script>

<div class="container mt-lg">
    <input class="form-control" type="number" bind:this={deposit} min="0">
    <button  class="btn btn-secondary mt-sm" on:click={depositEth}>
        deposit
    </button>
  
    <input class="form-control mt-md" type="number" bind:this={withdraw} min="0">
    <button class="btn btn-secondary mt-sm" on:click={withdrawEth}>
        withdraw
    </button>

    <input class="form-control mt-md" type="number" bind:this={entryFee} min="0">
    <button class="btn btn-secondary mt-sm" on:click={changeEntryFee}>
        change entry fee
    </button>

    <input class="form-control mt-md" type="number" bind:this={chainlinkFee} min="0">
    <button class="btn btn-secondary mt-sm" on:click={changeChainlinkFee}>
        change chainlink fee
    </button>
</div>
