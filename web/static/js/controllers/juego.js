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

	$scope.status_msg = "Esperando a jugador2"
	$scope.salaNombre = salaNombre;
	$scope.tableroShow = false

  var socket = new Socket("/socket", {});
  socket.connect();

	channel = socket.channel("juego:" + salaNombre, o);

	channel.on('empezar_juego', function() {
		$scope.status_msg = "A jugar";
		$scope.tableroShow = true;
		$scope.$digest();
	});

	channel.on('proxima_mano', function() {
		$scope.tableroShow = true;
		$scope.$digest();
	});

	channel.on('ping', function() {
		channel.push("pong", {});
	});





	channel.join();


	$scope.jugar = function(opcion) {
		$scope.tableroShow = false;
		channel.push("jugar", opcion);
	};

}]);
