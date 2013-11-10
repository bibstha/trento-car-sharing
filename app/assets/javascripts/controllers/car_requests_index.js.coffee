window.CarRequestsIndexCtrl = ($scope, $routeParams, $resource, $location, $rootScope) ->
  $scope.CarRequest = $resource '/api/teams/:teamId/car_requests/:carRequestId.json', 
    {teamId: $routeParams['teamId']}, # urlParams
    {update: {method: 'PUT'}} # Extra services

  $scope.init = ->
    $scope.car_requests = $scope.CarRequest.query()
  
  $scope.new = ->
    $location.url('/teams/' + $routeParams['teamId'] + '/car_requests/new')

  $scope.edit = (car_request) ->
    $location.url ['/teams/', $routeParams['teamId'], '/car_requests/',
      car_request._id.$oid
    ].join("")

  
    

