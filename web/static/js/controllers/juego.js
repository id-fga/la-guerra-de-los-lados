import {Socket, LongPoller} from "phoenix";

angular.module('app').controller('juegoController',
['$scope', '$rootScope', '$location', '$routeParams',
function($scope, $rootScope, $location, $routeParams) {
	var salaNombre = $routeParams.salaNombre;
	var jugadorNombre = $routeParams.jugadorNombre;

	o = {
				salaNombre: salaNombre,
				jugadorNombre: jugadorNombre
	};

	$scope.salaNombre = salaNombre;

  var socket = new Socket("/socket", {});
  socket.connect();


	channel = socket.channel("juego:" + salaNombre, o);







	channel.join();


}]);
