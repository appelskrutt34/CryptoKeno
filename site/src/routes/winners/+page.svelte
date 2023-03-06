<script>
    import {web3, winners} from "../../stores/web3";
</script>

<div class="container center-h mt-lg">
    <div style="text-align: center;">
        <h1>Winners history</h1>
        <div class="table mt-lg">
            <div class="table-header table-row direction-row" style={$winners.length == 0 ? 'border: none !important;' : ''}>
                <p class="address-cell ">Address</p>
                <p class="cell">Numbers</p>
                <p class="cell">Date</p>
                <p class="cell">Price</p>
            </div>
            {#each $winners as winner, i}
            <div class="table-row direction-row" style={$winners.length == i ? 'border: none !important;' : ''}>
                <p class="address-cell ">{winner.player}</p>
                <p class="cell">{winner.numbers}</p>
                <p class="cell">{new Date(parseInt(winner.date * 1000)).toLocaleDateString()}</p>
                <p class="cell">{$web3.utils.fromWei(winner.price)} ETH</p>
            </div>
            {/each}
        </div>
       </div> 
</div>