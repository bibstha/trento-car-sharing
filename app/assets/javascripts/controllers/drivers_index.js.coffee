window.DriversIndexCtrl = ($scope, $routeParams, $resource, $location, $rootScope) ->
  $scope.Driver = $resource '/api/teams/:teamId/drivers/:driverId.json', 
    {teamId: $routeParams['teamId']}, # urlParams
    {update: {method: 'PUT'}} # Extra services

  $scope.init = ->
    $scope.drivers = $scope.Driver.query()
  
  $scope.new = ->
    $location.url('/teams/' + $routeParams['teamId'] + '/drivers/new')

  $scope.edit = (driver) ->
    $location.url ['/teams/', $routeParams['teamId'], '/drivers/',
      driver._id.$oid
    ].join("")

  
    

