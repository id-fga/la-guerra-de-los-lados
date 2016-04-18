angular.module('app',['ngRoute']).
config(['$routeProvider',
	function($routeProvider) {
		$routeProvider.
		when('/', {
			templateUrl: 'web/static/templates/home.html',
			controller: 'HomeCtrl'
		}).
		when('/lobby/:jugadorNombre', {
			templateUrl: 'web/static/templates/lobby.html',
			controller: 'lobbyController'
		}).
		when('/juego/:salaNombre/:jugadorNombre/:jugadorNro?', {
			templateUrl: 'web/static/templates/juego.html',
			controller: 'juegoController'
		});
}]).
run(['$location', '$rootScope',
	function($location, $rootScope) {
  	$rootScope.$location = $location;
}]);
