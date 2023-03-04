<script>
    import Web3  from "web3";
    import { web3, account, contract, pricePool,drawCountDown} from "../stores/web3";
    import {getShortAddress} from "../helpers/helper";
    import  artifact  from "../contracts/Keno.json";


    const connect = async() => {
        if (window.ethereum) { 
            await window.ethereum.request({method: 'eth_requestAccounts'});    
            $web3 = window.web3 = new Web3(window.ethereum);    
            let accounts = await $web3.eth.requestAccounts();
            $account = accounts[0];

            try {
                $contract = new $web3.eth.Contract( artifact.abi, artifact.networks[5777].address, { from: $account });
                setPricePool();
                setDrawCountDown();
                listenForPricePoolUpdate();
            } catch (error) {
                console.error(error);
            }
        }
    }

    const listenForPricePoolUpdate = () => {
        $contract.events.PricePoolUpdated()
        .on("data", (data) => 
        {
            $pricePool = $web3.utils.fromWei(data.returnValues.new_price, 'ether');
            $drawCountDown = data.returnValues.new_draw;
        })
        .on("error", function (error) {
            console.log(error);
        });
    }

    const setPricePool = async() => {
        let priceInWei =await $contract.methods.getPricePool().call();
        $pricePool = $web3.utils.fromWei(priceInWei, 'ether');
         
    }
    const setDrawCountDown = async () => {
        $drawCountDown = await $contract.methods.getDrawCountDown().call();
    }

</script>

<nav style="color: white; padding: 1rem">
    <div class="container" style="display: flex; justify-content: end;">
        {#if $account}
            <p>{getShortAddress($account)}</p>
        {:else}
            <button on:click={connect} class="btn btn-primary">Connect wallet<img src="/MetaMask_Fox.svg.png" alt="" width="25xp"> </button>
        {/if}
      </div>
</nav>

<slot />

<style global>
	@import '../theme/app.css';
</style>