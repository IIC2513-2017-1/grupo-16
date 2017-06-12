// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function () {
  $("#number-search").bind("keyup", function() {
    var formData = $("#number-search").val();

    $(".check-box-item").each(function() {
      if (isNaN(formData)) {
        $("#nan-error").html("Por favor ingrese un número válido.");
      }
      else if ($(this).find(".check-box-label").html().startsWith(formData)) {
        $(this).show()
        $("#nan-error").html("");
      }
      else {
        $(this).hide()
        $("#nan-error").html("");
      }
    });
  })

  $("#check-box-list-form").bind("submit", function(event) {
    if ($("input[type='checkbox'][name='numbers[]']:checked").length === 0) {
      $("#nan-error").html("Debes seleccionar al menos un número.");
      return false;
    }
  });
});


