$(document).ready(function() {

  // Hook up an event handler for the load button click.
  // Wait to initialize until the button is clicked.
  $("#extension_api_init").click(function() {

    // Disable the button after it's been clicked
    $("#extension_api_init").prop('disabled', true);

    tableau.extensions.initializeAsync().then(function() {

      // Initialization succeeded! Get the dashboard
      const dashboard = tableau.extensions.dashboardContent.dashboard;
      var datasource = dashboard.worksheets[0].getDataSourcesAsync().then(function(datasource_promises){
        return datasource_promises[0];
      }).then(function(datasource_promise){
        return datasource_promise.getUnderlyingDataAsync(maxRows = 5).then(function(datasource){
          return datasource._data;
        });
      });

      // Display the name of dashboard in the UI
      $("#dsh_name_display").html("I'm running in a dashboard named <strong>" + dashboard.name + "</strong>");
      $("#rslt").html("Here's the first five (5) rows of the datasource." + datasource + " ... ");
      
      Shiny.setInputValue("data", datasource);
      
    }, function(err) {

      // something went wrong in initialization
      $("#dsh_name_display").html("Error while Initializing: " + err.toString());
    });
  });
});

