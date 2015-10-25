$(document).ready(function() {

  $('#flash_close').on('click', function() {
    $('#flash_alert').animate({
      right: '-=999',
      opacity: 0
    }, 900);
  });

});



