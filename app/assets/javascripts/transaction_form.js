$(document).on('turbolinks:load', function() {
  //Resource to load specific view javascript 
  $("#transaction-form-modal").modal({
    ready: function(modal, trigger) {
      $("#origin-account-field").hide();
      $("#destination-account-field").hide();
      $('#transaction-type-field :input').on('change', function() {
        var field = $('#transaction-type-field :input');
        if (field.val() == "deposit"){
          $("#origin-account-field").hide();
          $("#destination-account-field").show();
        } else if(field.val() == "withdrawal") {
          $("#origin-account-field").show();
          $("#destination-account-field").hide();
        } else if (field.val() == "transfer"){
          $("#origin-account-field").show();
          $("#destination-account-field").show();
        }
      })
      $("#submit-button").on('click', function(e){
        if (validateTransactionsFormFields()){
          dataAdjustment("#transaction_amount_in_cents");
          $("#submit-button").submit();
        } else { 
          e.preventDefault();
        }
      });
    }
  })
});

function validateTransactionsFormFields(){
  result = true;
  if(!validateSelectTagPresence("#transaction-type-field")){

  }
  if (!validateEquiness("#origin-account-field", "#destination-account-field","Conta de destino e de origem não podem ser iguais"))
  {
    result = false;
  }
  if (!validatePresence("#transaction_amount_in_cents")) {
    result = false;
  }
  if (!validatePresence("#transaction_date")) {
    result = false;
  }
  return result
}

