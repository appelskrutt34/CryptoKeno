<script>
    import {web3, winners} from "../../stores/web3";

</script>

<div class="container center-h mt-lg">
    <div style="text-align: center;">
        <h1>Previous winners</h1>
        <div class="table mt-lg">
            <div class="table-header table-row direction-row ">
                <p class="address-cell ">Address</p>
                <p class="cell">Numbers</p>
                <p class="cell">Date</p>
                <p class="cell">Price</p>
            </div>
            {#each $winners as winner, i}
            <div class="table-row direction-row" style={winners.length == i ? 'border: none !important;' : ''}>
                <p class="address-cell ">{winner.player}</p>
                <p class="cell">{winner.numbers}</p>
                <p class="cell">{new Date(parseInt(winner.date)).toLocaleDateString()}</p>
                <p class="cell">{$web3.utils.fromWei(winner.price)} ETH</p>
            </div>
            {/each}
        </div>
       </div> 
</div>

<style>
    .cell {
        text-align: center;
        width: 13rem;
    }
    .address-cell {
        text-align: center;
        width: 25rem;
    }
    .table-header {
        font-size: 1.2rem;
        font-weight: bold;
    }
    .table-row {
        padding: 1rem;
        border-bottom: 1px solid var(--lightgray);
    }
    .table {
        color: white;
        border-radius: 1rem;
        border: 1px solid var(--lightgray);
    }
</style>