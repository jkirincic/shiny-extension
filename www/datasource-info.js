$(document).ready(function() {
  
  tableau.extensions.initializeAsync().then(function() {
    
    var dsh = tableau.extensions.dashboardContent.dashboard;
    var ds = dsh.worksheets[0].getDataSourcesAsync().then(
      datasources => { myguy = datasources[0]; return myguy.getUnderlyingDataAsync(maxRows = 10);}
      );
    
    Shiny.setInputValue("data", ds);
    
  });
  
});

$(document).ready(function() {

  // Hook up an event handler for the load button click.
  // Wait to initialize until the button is clicked.
  $("#extension-api-init").click(function() {

    // Disable the button after it's been clicked
    $("#extension-api-init").prop('disabled', true);

    tableau.extensions.initializeAsync().then(function() {

      // Initialization succeeded! Get the dashboard
      var dashboard = tableau.extensions.dashboardContent.dashboard;

      // Display the name of dashboard in the UI
      $("#dsh_name_display").html("I'm running in a dashboard named <strong>" + dashboard.name + "</strong>");
    }, function(err) {

      // something went wrong in initialization
      $("#dsh_name_display").html("Error while Initializing: " + err.toString());
    });
  });
});

