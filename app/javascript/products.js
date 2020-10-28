window.addEventListener("DOMContentLoaded", () => {

  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
  const inputValue = priceInput.value;

    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");
    if( 300 <= inputValue && inputValue <= 9999999){
    addTaxDom.innerHTML = Math.floor(inputValue / 10);
    profitDom.innerHTML = inputValue - Math.floor(inputValue / 10);
    }else{
      addTaxDom.innerHTML = NaN;
      profitDom.innerHTML = NaN;
    };
  })

})