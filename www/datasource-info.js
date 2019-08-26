$(document).ready(function() {

  // Hook up an event handler for the load button click.
  // Wait to initialize until the button is clicked.
  $("#extension_api_init").click(function() {

    // Disable the button after it's been clicked
    $("#extension_api_init").prop('disabled', true);
    
    tableau.extensions.initializeAsync().then(function() {
      
      // Initialization succeeded! Get the dashboard
      const dashboard = tableau.extensions.dashboardContent.dashboard;
      var payload = [];
      var step1 = dashboard.worksheets[0].getDataSourcesAsync();
      var step2 = step1.then(function(x){ x[0] });
      var step3 = step2.then(function(x){ x.getUnderlyingDataAsync() });
      var step4 = step3.then(function(x){ x._data });
      step4.then(function(x){ payload.push(x) });
      
      // Display the name of dashboard in the UI
      $("#dsh_name_display").html("I'm running in a dashboard named <strong>" + dashboard.name + "</strong>");
      Shiny.setInputValue("data", payload[0][0]);
    }, function(err) {

      // something went wrong in initialization
      $("#dsh_name_display").html("Error while Initializing: " + err.toString());
    });
  });
});

