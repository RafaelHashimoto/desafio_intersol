$(document).on('turbolinks:load', function() {
  //Resource to load specific view javascript 
  if ($("body").data('controller') == 'sessions' && $("body").data('action') == 'new'){
    $("#submit-button").on('click', function(e){
      if (validate_fields()){
        $("#submit-button").submit();
      } else { 
        e.preventDefault();
      }
      
    });
  }
});

function validate_fields(){
  if(validateEmail('#user_email') && validatePassword('#user_password')){
    return true
  } else {
    return false
  }
}
