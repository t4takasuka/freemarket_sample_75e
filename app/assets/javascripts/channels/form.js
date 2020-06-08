$(document).on('turbolinks:load',()=> {
  $(".price__input-sell").on('keyup', function(){
    var price = $(".price__input-sell").val();
    if( 300 <= price && price <= 9999999) {
    var fee = Math.floor(price / 10);
    var profit = (price - fee);
    $(".price__fee--totalPrice").text(fee);
    $(".price__profit--totalPrice").text(profit);
    }else{
    $(".price__fee--totalPrice").text('');
    $(".price__profit--totalPrice").text('');
    }
  })
});