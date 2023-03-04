
<script>
    import Keno from "../components/Keno.svelte";
    import {pricePool,drawCountDown} from "../stores/web3";

</script>

<div class="container center-h" style="margin-top: 4rem;">
    <div style="text-align: center;">
        <h1>Price pool</h1>
        <div class="center-h">
            <div class="mt-xs" style="display: flex; flex-direction: row;">
                <h1 style="font-weight: 800; font-size: 4rem; margin-right: .5rem;">{$pricePool}</h1><img src="/icons/ethereum.svg" width="35px" alt="">
            </div>
        </div>
        <img src="/icons/divider.svg" width="150px" alt="">
        <p class="mt-lg">Bets until next draw: <span style="font-weight: 800;">{$drawCountDown}</span> </p>
        <div class="center-h mt-md">
            <Keno/>
        </div>
    </div>
</div>



