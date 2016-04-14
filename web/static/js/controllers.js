function LaGuerraController($scope, $http) {
		$scope.guerra = {};
    $scope.guerra.nombreJugador = '';


	$scope.ingresar = function() {
		alert($scope.guerra.nombreJugador);
	};


}
