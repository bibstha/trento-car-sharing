window.mainApp = angular.module('mainApp', ['ngRoute', 'ngResource', 'angularFileUpload']).config [
  '$routeProvider',
  ($routeProvider) ->
    $routeProvider
      .when('/teams/new', {templateUrl: '/templates/dashboard.html', controller: 'DashboardCtrl'})
      .when('/teams/:teamId', {templateUrl: '/templates/dashboard.html', controller: 'DashboardCtrl'})

    $routeProvider
      .when('/teams/:teamId/drivers', {templateUrl: '/templates/drivers_index.html', controller: 'DriversIndexCtrl'})
      .when('/teams/:teamId/drivers/new', {templateUrl: '/templates/drivers_create_update.html', controller: 'DriversCreateUpdateCtrl'})
      .when('/teams/:teamId/drivers/:driverId', {templateUrl: '/templates/drivers_create_update.html', controller: 'DriversCreateUpdateCtrl'})

    $routeProvider
      .when('/teams/:teamId/car_requests', {templateUrl: '/templates/car_requests_index.html', controller: 'CarRequestsIndexCtrl'})

    $routeProvider
      .otherwise({redirectTo: '/'})
]
window.mainApp.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken