$("document").ready(function() {
  $("#first-tab").click(function(){
    switchClass("#first-tab", "#second-tab");      
  });
  $("#second-tab").click(function(){
    switchClass("#second-tab" ,"#first-tab");      
  });
  $("#third-tab").click(function(){
    switchClass("#third-tab" ,"#first-tab");      
  });
});

function switchClass(id1, id2){
  $(id1).addClass("selected");
  $(id2).removeClass("selected");
}