<script>
    import Web3  from "web3";
    import { web3, account, contract} from "../stores/web3";
    import {getShortAddress} from "../api/web3";
    import  artifact  from "../contracts/Keno.json";

    const connect = async() => {
        if (window.ethereum) { 
            await window.ethereum.request({method: 'eth_requestAccounts'});    
            $web3 = window.web3 = new Web3(window.ethereum);    
            let accounts = await $web3.eth.requestAccounts();
            $account = accounts[0];

            try {
                $contract = new $web3.eth.Contract( artifact.abi, artifact.networks[5777].address, { from: $account });
                console.log($contract);
            } catch (error) {
                console.error(error);
            }
        }
    }
</script>

<nav style="color: white; padding: 1rem">
    <div class="container" style="display: flex; justify-content: end;">
        {#if $account}
            <p>{getShortAddress($account)}</p>
        {:else}
            <button on:click={connect} class="btn btn-primary">Connect wallet <img src="/MetaMask_Fox.svg.png" alt="" width="25xp"> </button>
        {/if}
      </div>
</nav>

<slot />

<style global>
	@import '../theme/app.css';
</style>