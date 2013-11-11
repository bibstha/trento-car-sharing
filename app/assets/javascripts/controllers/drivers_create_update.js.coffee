window.DriversCreateUpdateCtrl = ($scope, $routeParams, $resource, $location, $fileUploader) ->
  $scope.Driver = $resource '/api/teams/:teamId/drivers/:driverId.json', 
    {teamId: $routeParams['teamId']}, # urlParams
    {update: {method: 'PUT'}} # Extra services

  # create a uploader with options
  uploader = $scope.uploader = $fileUploader.create({
    scope: $scope,
    url: ['/api/teams/', $routeParams['teamId'], '/drivers/', $routeParams['driverId'], '/documents'].join(''),
    formData: [
      { authenticity_token: $('meta[name="csrf-token"]').attr('content') }
    ],
    filters: [
      (item) ->
        console.log('filter1');
        return true;
    ]
  });

  uploader.bind('afteraddingfile', (event, item) ->
    console.log('After adding a file', item);
  );

  uploader.bind('success', (event, xhr, item) ->
    console.log('Success: ' + xhr.response, item);
    if !$scope.driver.documents?
      $scope.driver.documents = []
    
    $scope.driver.documents.push(angular.fromJson(xhr.response).name.path)
    console.log $scope.driver
  );

  uploader.bind('complete', (event, xhr, item) ->
    console.log('Complete: ' + xhr.response, item);
  );

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

  # $scope.remove_existing_document = document ->
  #   service = $resource '/api/teams/:teamId/'
    

  
    

