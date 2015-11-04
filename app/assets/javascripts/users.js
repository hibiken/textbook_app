$(document).on('ready page:load', function() {
  var $action_icons = $('.action_icons');

  $action_icons.hide();
  $('#users_show_item').on('mouseenter',function() {
    $action_icons.show();
  });

  $('#users_show_item').on('mouseleave', function(){
    $action_icons.hide();
  });
});