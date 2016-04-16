//TODO: Pasar nombre home a otra nomenclatura
angular.module('app').controller('HomeCtrl',
['$scope', '$rootScope', '$location', '$routeParams',
function($scope, $rootScope, $location, $routeParams) {

	//TODO: Simplificar esto
	$scope.guerra = {};
	$scope.guerra.nombreJugador;

  $scope.ingresar = function() {

		$location.url('/lobby/'+$scope.guerra.nombreJugador);

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
