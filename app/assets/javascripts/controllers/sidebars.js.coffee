window.SidebarsCtrl = ($scope, $routeParams, $resource, $location, $rootScope) ->
  $scope.init = ->
    $scope.links = [
      {id: 'team', name: 'Step 1', description: 'Team information'},
      {id: 'driver', name: 'Step 2', description: 'Individual drivers information'},
      {id: 'finish', name: 'Step 3', description: 'Finish'},
    ]

  $scope.show_sidebar = ->
    teamId?

  $scope.click = (link) ->
    if (link.id == 'team')
      url = ['/teams/', $routeParams['teamId']].join("")
      $location.url url
    else if link.id == 'driver'
      url = ['/teams/', $routeParams['teamId'], '/drivers/'].join("")
      $location.url url
    else if link.id == 'finish'
      url = ['/teams/', $routeParams['teamId'], '/finish/'].join("")
      $location.url url

    

