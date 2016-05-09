angular.module('app').controller('lobbyController',
['$scope', '$http', '$rootScope', '$location', '$routeParams',
function($scope, $http, $rootScope, $location, $routeParams) {
  
  $http.get('api/salas/').success(function(r) {
    $scope.salas_disponibles = r.salas;
		console.log($scope.salas_disponibles);
  });

	var jugadorNombre = $routeParams.jugadorNombre;

	$scope.jugadorNombre = jugadorNombre;
	$scope.salaNombre = "sala-de-"+jugadorNombre;


	$scope.crearSala = function() {
		$location.url('/juego/'+$scope.salaNombre+'/'+$scope.jugadorNombre+'/jugador1');
	};

}]);
