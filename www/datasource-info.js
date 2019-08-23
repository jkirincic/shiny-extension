$(document).on('shiny:sessioninitialized', function(event) {
  
  alert('Session initialized. Fetching datasource info...');
  
  tableau.extensions.initializeAsync().then(function() {
    var dsh = tableau.extensions.dashboardContent.dashboard;
    Shiny.setInputValue("dsh_name", dsh.name);
  })
  
});