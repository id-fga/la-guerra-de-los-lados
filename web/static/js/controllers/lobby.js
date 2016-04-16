angular.module('app').controller('lobbyController',
['$scope', '$rootScope', '$location', '$routeParams',
function($scope, $rootScope, $location, $routeParams) {
	var jugadorNombre = $routeParams.jugadorNombre;

	$scope.jugadorNombre = jugadorNombre;

}]);
