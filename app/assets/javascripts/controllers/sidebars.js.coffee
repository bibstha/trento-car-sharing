window.SidebarsCtrl = ($scope, $routeParams, $resource, $location, $rootScope) ->
  $scope.init = ->
    $scope.links = [
      {id: 'team', name: 'Step 1'},
      {id: 'driver', name: 'Step 2'},
      {id: 'car_request', name: 'Step 3'},
    ]

  $scope.click = (link) ->
    if (link.id == 'team')
      url = ['/teams/', $routeParams['teamId']].join("")
      $location.url url
    else if link.id == 'driver'
      url = ['/teams/', $routeParams['teamId'], '/drivers/'].join("")
      $location.url url
    else if link.id == 'car_request'
      url = ['/teams/', $routeParams['teamId'], '/car_requests/'].join("")
      $location.url url

    

