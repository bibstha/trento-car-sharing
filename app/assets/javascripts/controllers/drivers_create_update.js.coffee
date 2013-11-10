window.DriversCreateUpdateCtrl = ($scope, $routeParams, $resource, $location, $rootScope) ->
  $scope.Driver = $resource '/api/teams/:teamId/drivers/:driverId.json', 
    {teamId: $routeParams['teamId']}, # urlParams
    {update: {method: 'PUT'}} # Extra services

  $scope.init = ->
    if not $routeParams['driverId']?
      $scope.driver = new $scope.Driver()
    else
      $scope.driver = $scope.Driver.get({driverId: $routeParams['driverId']})

  $scope.submit = ->
    if $scope.driver._id?
      $scope.driver.$update({driverId: $routeParams['driverId']})
    else
      $scope.driver.$save()
    
    $location.url '/teams/' + $routeParams['teamId'] + '/drivers'
    

  
    

