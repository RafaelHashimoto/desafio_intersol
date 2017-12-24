$(document).on('turbolinks:load', function() {
  $('select').material_select();
  $('.modal').modal();
  $(".button-collapse").sideNav();
  $('ul.tabs').tabs();
  $('.dropdown-button').dropdown({
    hover: false, // Activate on hover
    gutter: 0, // Spacing from edge
    belowOrigin: false, // Displays dropdown below the button
    alignment: 'left', // Displays dropdown with edge aligned to the left of button
    stopPropagation: false // Stops event propagation
  }
);
});