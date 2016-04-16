angular.module('app').controller('HomeCtrl',
['$scope', '$rootScope', '$location', '$routeParams',
function($scope, $rootScope, $location, $routeParams) {

	$scope.guerra = {};
	$scope.guerra.nombreJugador;

  $scope.ingresar = function() {

		alert($scope.guerra.nombreJugador);

		/*
    if(name && name.trim().length > 0) {
      $cookies.put("name", name);
      $rootScope.name = name;
      if($routeParams.game_id)
        $location.url('/games/'+encodeURIComponent($routeParams.game_id));
      else
        $location.path('/games');
    } else {
      $scope.errors = {name: true};
    }
	*/
  };

}]);
