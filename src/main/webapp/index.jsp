<!DOCTYPE HTML>
<html ng-app="" ng-controller="reloadParkingInfo">
    <head>
        <title>Estacionamento Técnico Lisboa</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0;">
        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" type="text/css" href="css/fonts.css">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js"></script>
    </head>
    <body>
        <header>
            <img src="images/logo.svg" alt="Tecnico Lisboa" id="logo" />
            <div id="time-wrap">
                <time id="hours">{{timeSlot}}</time>
                <time id="date">{{dateSlot}}</time>
            </div>
        </header>
        <article>
            <table id="ptable">
                <img src="images/logo-mobile.svg" alt="Tecnico Lisboa" id="logo-mobile" />
                <tr>
                    <td>Parque</td>
                    <td>Lugares disponíveis</td>
                </tr>
                <tr class="{{classAlameda}}">
                    <td>Campus Alameda</td>
                    <td class="spot">{{slotsAlameda}}</td>
                </tr>
                <tr class="{{classArcoCego}}">
                    <td>Arco do Cego</td>
                    <td class="spot">{{slotsArcoCego}}</td>
                </tr>
            </table>
        </article>
    </body>
    <script type="text/javascript">
        function reloadParkingInfo($scope, $http, $location, $interval) {
            $scope.slotsAlameda = "";
            $scope.classAlameda = "";
            $scope.slotsArcoCego = "";
            $scope.classArcoCego = "";
            var contextPath = '<%= request.getContextPath() %>';

            moment.locale("pt-PT");

            var updateDate = function() {
                var now = moment().locale("pt");
                $scope.timeSlot = now.format("HH:mm:ss");
                $scope.dateSlot = now.format("D MMMM YYYY");
            };

            var updatePark = function() {
                $http.get(contextPath + "/info.jsp").success(function(response) {
                    var infoAlameda = response['Alameda'];
                    var freeSlotsAlameda = infoAlameda['freeSlots'];
                    var totalSlotsAlameda = infoAlameda['total'];
                    $scope.slotsAlameda = freeSlotsAlameda;
                    $scope.totalAlameda = totalSlotsAlameda;
                    $scope.classAlameda = getOccupationClass(freeSlotsAlameda, totalSlotsAlameda);

                    var info = response['Arco Do Cego'];
                    var freeSlots = info['freeSlots'];
                    var totalSlots = info['total'];
                    $scope.slotsArcoCego = freeSlots;
                    $scope.total = totalSlots;
                    $scope.classArcoCego = getOccupationClass(freeSlots, totalSlots);
                });
            };
            
            updateDate();
            updatePark();

            $interval(function () {
                updateDate();
            }, 1000);
            
            $interval(function () {
                updatePark();
            }, 1000);
        }

        function getOccupationClass(freeSlots, totalSlots) {
            var p = freeSlots / totalSlots;
            if (freeSlots == 0) {
                return "full";
            } else if (p < 0.15) {
                return "half";
                $scope.classArcoCego = "half";
            } else {
                return "";
            }            
        }
    </script>
</html>