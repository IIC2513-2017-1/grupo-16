// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function () {
  $("#number-search").bind("keyup", function() {
    var formData = $("#number-search").val(); // grab the form wrapping the search bar.
    console.log(formData)

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

  });
});
