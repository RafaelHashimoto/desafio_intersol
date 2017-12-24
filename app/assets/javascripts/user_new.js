$(document).on('turbolinks:load', function() {
  //Resource to load specific view javascript 
  if ($("body").data('controller') == 'registrations' && $("body").data('action') == 'new'){
    $("#user-new-submit-button").on('click', function(e){
      if (validate_fields()){
        $("#submit-button").submit();
      } else { 
        e.preventDefault();
      }
    });
  }
});

function validate_fields(){
  result = true;
  if (!validateTextOnly("#user_first_name")){
    result = false;
  }
  if (!validateTextOnly("#user_last_name")){
    result = false;
  }
  if(!validateEmail('#user_email')){
    result = false;
  } 
  if (!validatePassword('#user_password')){
    result = false;
  } 
  if (!validatePasswordConfirmation("#user_password_confirmation", "#user_password")){
    result = false;
  }
  return result;
}
