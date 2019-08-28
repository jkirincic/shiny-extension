shinyjs.init = function(){
  tableau.extensions.initializeAsync().then(function(){
    const dashboard = tableau.extensions.dashboardContent.dashboard;
    var payload = [];
    var step1 = dashboard.worksheets[0].getDataSourcesAsync();
    var step2 = step1.then(function(x){ return x[0] });
    var step3 = step2.then(function(x){ return x.getUnderlyingDataAsync() });
    step3.then(function(x){ payload.push(x); Shiny.setInputValue("data", payload[0]);});
  });
}