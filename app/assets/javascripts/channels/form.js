$(function(){
  $('#price_calc').on('input', function(){   
    var data = $('#price_calc').val(); 
    var profit = Math.round(data * 0.9)  
    var fee = (data - profit) 
    $('.price__fee').html(fee) 
    $('.price__fee').prepend('¥') 
    $('.price__profit').html(profit)
    $('.price__profit').prepend('¥')
    $('#price').val(profit) 
    if(profit == '') {   
    $('.price__profit').html('');
    $('.price__fee').html('');
    }
  })
})