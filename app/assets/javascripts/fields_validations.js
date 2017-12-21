function validateEmail(id, submit_button_id){
  var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!regex.test($(id).val())) {
    set_error_class(id);
    return false;
  } else {
    remove_error_class(id);
    return true
  }
}
function validatePassword(id, submit_button_id){
  if ($(id).val() == null || $(id).val().length < 6) {
    set_error_class(id);
    return false;
  } else {
    remove_error_class(id);
    return true;
  }
}

function validate_password_confirmation(id, password_id){
  if ($(id).val() == null || $(id).val().length < 6) {
    set_error_class(id);
    $("#password_confirmation_error").text("Campo inválido");
  } else if ($(id).val() != $(password_id).val()){
    set_error_class(id);
    $("#password_confirmation_error").text("As senhas devem ser iguais");
  } else {
    $(id).parent().removeClass("field_with_errors");
    $(id).parent().addClass("valid-field");
    
    document.getElementById("button").disabled = false;
    
    $("#form-button").removeClass("form-button-disable");
    $("#form-button").addClass("form-button");
    $("#password_confirmation_error").text("");
  }
}

function set_error_class(id){
  $(id).parent().removeClass("valid-field");
  $(id).parent().addClass("field_with_errors");
}
function remove_error_class(id){
  $(id).parent().removeClass("field_with_errors");
  $(id).parent().addClass("valid-field");
}