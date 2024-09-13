$(document).on('turbolinks:load', function() {
  $('#weatherForm').on('ajax:success', function(event) {
    var [data, status, xhr] = event.detail;
    
    // Insert the partial response inside the weatherResult div
    $('#weatherResult').html(xhr.responseText);
  }).on('ajax:error', function(event) {
    alert('Error fetching weather data');
  });
});
