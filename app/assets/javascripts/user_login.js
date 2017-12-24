$(document).on('turbolinks:load', function() {
  //Resource to load specific view javascript 
  if ($("body").data('controller') == 'sessions' && $("body").data('action') == 'new'){
    $("#submit-button").on('click', function(e){
      if (validate_login_fields()){
        $("#login-submit-button").submit();
      } else { 
        e.preventDefault();
      }
    });
  }
});

function validate_login_fields(){
  if(validateEmail('#user_email') && validatePassword('#user_password')){
    return true
  } else {
    return false
  }
}
