<script>
    import { onMount } from "svelte";
    import { contract,web3 } from "../../stores/web3";
    import { goto } from '$app/navigation';
     
    let deposit;
    let withdraw;
    
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
</script>

<div class="container mt-lg">
    <input type="number" bind:this={deposit}>
    <button on:click={depositEth}>
        deposit
    </button>
    
    <input type="number" bind:this={withdraw}>
    <button on:click={withdrawEth}>
        withdraw
    </button>
</div>
