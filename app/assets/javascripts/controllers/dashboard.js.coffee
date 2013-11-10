window.DashboardCtrl = ($scope, $routeParams, $resource, $location, $rootScope, $timeout) ->
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
    successFn = (data) ->
      $scope.form.submitted = true
      $timeout(->
        $location.url('/teams/' + data._id.$oid + '/drivers/')
      , 2000)

    if not $routeParams["teamId"]?
      $scope.team.$save(successFn)
    else
      $scope.team.$update({teamId: $scope.team._id.$oid},
        successFn);
    
    
    # console.log("Submit Called")

