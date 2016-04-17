import {Socket, LongPoller} from "phoenix";

angular.module('app').controller('juegoController',
['$scope', '$rootScope', '$location', '$routeParams',
function($scope, $rootScope, $location, $routeParams) {
	var salaNombre = $routeParams.salaNombre;
	var jugadorNombre = $routeParams.jugadorNombre;
	var jugadorNumero = $routeParams.jugadorNro || 'jugador2';

	if(jugadorNumero != 'jugador1' && jugadorNumero != 'jugador2') {
		alert("ERROR");
		return;
	}

	o = {
				salaNombre: salaNombre,
				jugadorNombre: jugadorNombre,
				jugadorNumero: jugadorNumero
	};

	$scope.salaNombre = salaNombre;

  var socket = new Socket("/socket", {});
  socket.connect();

	channel = socket.channel("juego:" + salaNombre, o);







	channel.join();


}]);
