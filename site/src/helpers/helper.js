export function getShortAddress(address) {
  let length = address.length;
  return address.slice(0, 7) + "....." + address.slice(length - 5, length);
}

export const getUsdFromEth = async (eth) => {
  const response = await fetch(
    "https://api.coinbase.com/v2/exchange-rates?currency=ETH"
  );
  return response.USD * eth;
};
