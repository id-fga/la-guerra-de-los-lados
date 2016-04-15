function LaGuerraController($scope, $http) {
	$scope.formIngresarShow = true;
	$scope.pantallaPrincipalShow = false;

	$scope.guerra = {};
	$scope.guerra.nombreJugador;
    $scope.guerra.nombreJugador = "Sebastian";

	$scope.ingresar = function() {
		$scope.formIngresarShow = false;
		$scope.pantallaPrincipalShow = true;
	};


}
