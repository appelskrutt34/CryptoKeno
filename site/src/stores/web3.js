import { writable } from "svelte/store";

export const web3 = writable({});
export const account = writable();
export const contract = writable({});
export const pricePool = writable(0);
export const drawCountDown = writable(0);
export const winners = writable([]);
export const activeBet = writable({});
