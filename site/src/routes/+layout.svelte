<script>
    import Web3  from "web3";
    import { web3, account, contract, pricePool,drawCountDown, winners, activeBet} from "../stores/web3";
    import {getShortAddress} from "../helpers/helper";
    import  artifact  from "../contracts/Keno.json";
    import Popup from "../components/Popup.svelte";

    let recentDraws = [];

    const connect = async() => {
        if (window.ethereum) { 
            await window.ethereum.request({method: 'eth_requestAccounts'});    
            $web3 = window.web3 = new Web3(window.ethereum);    
            let accounts = await $web3.eth.requestAccounts();
            $account = accounts[0];

            try {
                $contract = new $web3.eth.Contract( artifact.abi, artifact.networks[5777].address);
                setPricePool();
                setDrawCountDown();
                setActiveBet();
                getWinners();
                listenForPricePoolUpdate();
                listenForLotteryDraw();
                listenForAccountsChange();        
            } catch (error) {
                console.error(error);
            }
        }
    }

    const listenForPricePoolUpdate = () => {
        $contract.events.pricePoolUpdated()
        .on("data", (data) => 
        {
            $pricePool = $web3.utils.fromWei(data.returnValues.new_price, 'ether');
            $drawCountDown = data.returnValues.new_draw;
        })
        .on("error", function (error) {
            console.error(error);
        });
    }

    const listenForLotteryDraw = () => {
        $contract.events.drawEnded()
        .on("data", (data) => 
        {
            recentDraws.push({numbers: data.returnValues.numbers, winners: data.returnValues.winner_count});
            recentDraws = recentDraws;

            getWinners();
            setPricePool();
            setDrawCountDown();
            setActiveBet();
        })
        .on("error", function (error) {
            console.error(error);
        });
    }

    const listenForAccountsChange = () => {
        window.ethereum.on('accountsChanged', function (accounts) {
           $account = accounts[0];
           setActiveBet();
        })
    }

    const setPricePool = async() => {
        let priceInWei =await $contract.methods.getPricePool().call({from: $account});
        $pricePool = $web3.utils.fromWei(priceInWei, 'ether'); 
    }
    const setDrawCountDown = async () => {
        $drawCountDown = await $contract.methods.getDrawCountDown().call({from: $account});
    }
    const setActiveBet = async () => {
        $activeBet = await $contract.methods.getActiveBet().call({from: $account});
    }
    const getWinners = async () => {
        $winners = await $contract.methods.getWinners().call();
    }
    const shift = () => {
        recentDraws.shift();
        recentDraws = recentDraws;
    }
</script>

{#each recentDraws as draw}
    <Popup numbers={draw.numbers} winners={draw.winners} {shift}/>
{/each}

<nav style="color: white;">
    <div class="container">
        <div>
            <div class="direction-row" style="padding: .8rem 0">
                <div class="center-v">
                    <a class="link" href="/">Keno</a>
                </div>
                <div class="center-v">
                    <a class="link" href="/winners">Winners</a>
                </div>  
                <div style="display: flex; justify-content: end; width: 100%">{#if $account}
                    <p>{getShortAddress($account)} <span style="background-color: var(--green3); height: 15px !important; width: 15px;  border-radius: 50%; display: inline-block; margin-left: .5rem"></span></p>
                {/if}</div>
            </div>
            
        </div>
      </div>
</nav>

{#if $account}
<slot />
{:else}
<div class="container" style="margin-top: 8rem; text-align: center;">
    <h1>Connect your MetaMask wallet to play</h1>
    <button on:click={connect} class="btn btn-primary mt-lg">Connect Wallet <img src="/MetaMask_Fox.svg.png" alt="" width="25xp"> </button>
</div>
   
{/if}


<style global>
@import '../theme/app.css';

nav {
    background-color: rgb(29, 29, 29);
    box-shadow: 0px 8px 8px rgba(0, 0, 0, .10);
}
.link {
    margin-right: 1rem;
  text-decoration: none;
  display: inline-block;
  position: relative;
}
.link:after {    
  background: none repeat scroll 0 0 transparent;
  content: "";
  display: block;
  height: 2px;
  left: 50%;
  position: absolute;
  background: #fff;
  transition: width 0.3s ease 0s, left 0.3s ease 0s;
  width: 0;
}
.link:hover:after { 
  width: 100%; 
  left: 0; 
}
</style>