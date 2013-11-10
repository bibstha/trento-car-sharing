window.DashboardCtrl = ($scope, $routeParams, $resource, $location, $rootScope) ->
  $scope.init = ->
    Team = $resource('/api/teams/:teamId.json',
      {},
      {update: {method: 'PUT'}}
    )
    if not $routeParams["teamId"]?
      $scope.team = new Team()
    else
      $scope.team = Team.get({teamId: $routeParams['teamId']}, (data) ->
        console.log data._id.$oid
      )

  $scope.submit = ->
    if not $routeParams["teamId"]?
      $scope.team.$save((data) ->
        $location.url '/teams/' + data._id.$oid
      );
    else
      $scope.team.$update({teamId: $scope.team._id.$oid});
    
    
    # console.log("Submit Called")

