
<script>
    import Keno from "../components/Keno.svelte";
    import {pricePool,drawCountDown,contract} from "../stores/web3";

</script>
{#if $contract.methods}
<div class="container  mt-lg">
    <div class="center-h">
    <div style="text-align: center;">
        <h1>Price pool</h1>
        <div class="center-h">
            <div class="mt-xs" style="display: flex; flex-direction: row;">
                <h1 style="font-weight: 800; font-size: 4rem; margin-right: .5rem;">{$pricePool}</h1><img src="/icons/ethereum.svg" width="35px" alt="">
            </div>
        </div>
        <p class="mt-lg">Bets until next draw: <span style="font-weight: 800;">{$drawCountDown}</span> </p>
        <div class="center-h mt-md">
            <Keno/>
        </div>
    </div>
    </div>
    <div style="text-align: center; position: absolute; bottom: 1rem; left: 0; right: 0; margin: auto;">
        <h2>How to play</h2>
        <div class="mt-sm">
            <p>Pick 5 numbers.
                <span style="display: block">Pay an entry fee of 0.005 ETH.</span>
                <span style="display: block">Wait until next draw (occurs every 20th bet).</span>
                <span style="display: block">Everyone who guessed the right numbers will share the price pool.</span>
                <span style="display: block">If no one guessed right, a new draw will be made after 20 new bets.</span>
                </p>
        </div>
    </div>
</div>
{:else}
<div class="container center-h" style="margin-top: 10rem" >
    <h1>Connect to meta mask to play</h1>
</div>
{/if}
<style>
</style>




