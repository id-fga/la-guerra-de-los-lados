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
	$scope.tablaResultadosShow = false;
  $scope.rfs;

  var socket = new Socket("/socket", {});
  socket.connect();

	channel = socket.channel("juego:" + salaNombre, o);

	channel.on('empezar_juego', function() {
		$scope.status_msg = "A jugar";
		$scope.tableroShow = true;
		$scope.$digest();
	});

	channel.on('proxima_mano', function(estado) {

		console.log(estado);

		$scope.tableroShow = true;
		$scope.mano_nro = 'Mano: '+estado.mano_numero;
		$scope.status_msg = estado.status;
		$scope.carta = estado.carta;
		$scope.$digest();
	});

	channel.on('ping', function() {
		channel.push("pong", {});
	});

	channel.on('fin_juego', function(r) {
		$scope.status_msg = '';
		$scope.mano_nro = '';
		$scope.tableroShow = false;
		$scope.tablaResultadosShow = true;

		//TODO: Esto debe hacerse en el servidor
    rfs = r['respuestas'].map(function(m) {
				o = {};

				if(m[0][0] == "jugador1") {
								o['jugador1'] = m[0][1];
								o['jugador2'] = m[1][1];
				} else {
								o['jugador1'] = m[1][1];
								o['jugador2'] = m[0][1];
				}

				return o;
		});
		$scope.rfs = rfs;
		console.log($scope.rfs);
		channel.leave();

		$scope.$digest();
	});





	channel.join();


	$scope.jugar = function(opcion) {
		$scope.tableroShow = false;
		channel.push("jugar", opcion);
	};

}]);
