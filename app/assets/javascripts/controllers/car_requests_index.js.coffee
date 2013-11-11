window.CarRequestsIndexCtrl = ($scope, $http, $routeParams) ->
  $scope.finish = ->
    $http.post('/api/teams/' + $routeParams['teamId'] + '/finish', {
      'authenticity_token': $("meta[name='csrf-token']").attr('content')
    })