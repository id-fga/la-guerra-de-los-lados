angular.module('app',['ngRoute', 'ngAnimate', 'monospaced.qrcode']).
config(['$routeProvider',
	function($routeProvider) {
		$routeProvider.
		when('/', {
			templateUrl: 'web/static/templates/home.html',
			controller: 'HomeCtrl'
		});
}]).
run(['$location', '$rootScope',
	function($location, $rootScope) {
  	$rootScope.$location = $location;
}]);
