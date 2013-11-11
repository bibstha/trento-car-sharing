window.FileDestroyController = ($scope, $http) ->
  file = $scope.file
  state = ''
  if file.url
    file.$state = ->
      return state
    file.$destroy = ->
      state = 'pending'
      return $http({
        url: file.deleteUrl,
        method: file.deleteType
      }).then(
        ->
          state = 'resolved';
          $scope.clear(file);
        ->
          state = 'rejected';
      )
  else if (!file.$cancel && !file._index) 
    file.$cancel = ->
      $scope.clear(file);
