import {Socket, LongPoller} from "phoenix";

angular.module('app').controller('juegoController',
['$scope', '$rootScope', '$location', '$routeParams',
function($scope, $rootScope, $location, $routeParams) {
	var salaNombre = $routeParams.salaNombre;
	var jugadorNombre = $routeParams.jugadorNombre;

	$scope.salaNombre = salaNombre;

  var socket = new Socket("/socket", {});
  socket.connect();
	console.log(socket);

	channel = socket.channel("juego:" + salaNombre, {jugadorNombre: jugadorNombre});







	channel.join();


}]);
