$(document).on('turbolinks:load', function() {
  //Resource to load specific view javascript 
  $("#edit_user_modal").modal({
    ready: function(modal, trigger) {
      $("#edit_user_submit_button").on('click', function(e){
        if (validateUserEditFields()){
          $("#edit-user-submit-button").submit();
        } else { 
          e.preventDefault();
        }
      });
    }
  })
});

function validateUserEditFields(){
  result = true;
  if        (!validateTextOnly("#user_first_name")) {
    result = false;
  }
  if (!validateTextOnly("#user_last_name")){
    result =  false;
  }
  if (!validateEmail('#user_email') ){
    result = false;
  }
  return result
}
