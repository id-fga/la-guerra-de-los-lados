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

	$scope.mano_nro;
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

	channel.on('proxima_mano', function(estado) {
		$scope.tableroShow = true;
		$scope.mano_nro = 'Mano: '+estado.mano_numero;
		$scope.carta = estado.carta;
		console.log($scope.carta);
		$scope.$digest();
	});

	channel.on('ping', function() {
		channel.push("pong", {});
	});

	channel.on('fin_juego', function(r) {
		console.log(r);
		$scope.status_msg = "Termino el juego";
		$scope.tableroShow = false;
		$scope.$digest();
	});





	channel.join();


	$scope.jugar = function(opcion) {
		$scope.tableroShow = false;
		channel.push("jugar", opcion);
	};

}]);
