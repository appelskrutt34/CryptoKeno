<script>
    import { onMount } from "svelte";

      export let numbers;
      export let winners;
      export let shift;
  
      onMount(() => {
        setTimeout(() => {
          shift()
        }, 5000)
      })
  </script>
  
    <div class="popuptext slide-in">
        <p>Draw: {numbers}</p>
        <p style="font-weight: 800;">{winners > 0 ? winners + ' winners' : '0 winners'}</p>
    </div>
  
    <style>
  .popuptext {
    width: 160px;
    background-color: var(--green3);
    color: white;
    text-align: center;
    border-radius: 6px;
    padding: 8px 0;
    position: absolute;
    align-self: center;
    top: -5rem;
    left:0;
    right:0;
    margin-left:auto;
    margin-right:auto;
    z-index: 999;
  }
  
    </style>