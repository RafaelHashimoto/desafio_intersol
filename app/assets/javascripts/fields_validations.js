function validateEmail(id){
  var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!$(id).val()){
    set_error_class(id, "Campo obrigatório");
    return false;
  } else if (!regex.test($(id).val())) {
    set_error_class(id, "Formato inválido");
    return false;
  } else {
    remove_error_class(id);
    return true
  }
}
function validateTextOnly(id){
  var regex = /(^[a-z ]+$)/i;
  if (!$(id).val()){
    set_error_class(id, "Campo obrigatório");
    return false;
  } else if (!regex.test($(id).val())) {
    set_error_class(id, "Formato inválido");
    return false;
  } else {
    remove_error_class(id);
    return true
  }
}
function validatePassword(id){
  if ($(id).val() == null || $(id).val().length < 6) {
    set_error_class(id, "Mínimo de 6 caractéres");
    return false;
  } else {
    remove_error_class(id);
    return true;
  }
}

function validatePasswordConfirmation(id, password_id){
  if ($(id).val() == null || $(id).val().length < 6) {
    set_error_class(id, "Mínimo de 6 caractéres");
    return false;
  } else if ($(id).val() != $(password_id).val()){
    set_error_class(id, "As senhas devem ser iguais");
    return false;
  } else {
    remove_error_class(id);
    return true;
  }
}

function set_error_class(id, message){
  $(id).parent().removeClass("valid-field");
  $(id).parent().addClass("field_with_errors");
  $(id).parent().find(".help-block").text(message)
}
function remove_error_class(id){
  $(id).parent().removeClass("field_with_errors");
  $(id).parent().addClass("valid-field");
  $(id).parent().find(".help-block").text("")
}