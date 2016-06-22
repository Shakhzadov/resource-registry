(function () {
   'use strict';

    angular
        .module('restApp')
        .controller('RequestsController', RequestsController);

    RequestsController.$inject = ['$scope', '$http', 'PaginationServicee', 'constant', '$location', '$rootScope'];
    function RequestsController($scope, $http, PaginationServicee, constant, $location, $rootScope) {

        $rootScope.xmlData = [];
        $rootScope.xmlData.items = [];
        $scope.reqQuery = 'requests/showrequest';
        $scope.searchType;
        $scope.requestSearch;


        (function(){
            return $http.get('rest.php/'+ $scope.reqQuery)
                .then(successHandler)
                .catch(errorHandler);
            function successHandler(data) {
                $rootScope.xmlData = data.data;
                $rootScope.xmlData.create_time = Date(data.data.create_time);
            }
            function errorHandler(result){
                console.log("Can't render list!");
                alert (result.data.message);
            }
        }());

        // search by senders username
        $scope.searchRequest = function(requestSearch) {
          // if ($scope.searchType == undefined ) {$scope.searchType = 0;}
            $http.get('rest.php/'+ $scope.reqQuery + '?option='+ $scope.searchType + '&value='+ $scope.requestSearch)
                .then(successHandler)
                .catch(errorHandler);
            function successHandler(data) {
                $rootScope.xmlData = data.data;
                $scope.searchingDone = $scope.searchType;
                $scope.searchingDone2 = $scope.requestSearch;
            }
            function errorHandler(data){
                console.log("Can't reload list!");
            }
        };

        // $scope.addRequest = function() {
        //   var data = {
            // type: $scope.requests.type,
            // sender: $scope.requests.sender,
            // reciever: $scope.requests.reciever,
            // status: $scope.requests.status
        //   };

        //   (function() {
        //     var post = $http.post('rest.php/requests/addreq', JSON.stringify(data))
        //       .then(successHandler)
        //       .catch(errorHandler);
        //     function successHandler(result) {
        //       console.log('Реєстрація пройшла успішно!');
        //     }
        //     function errorHandler(result){
        //       console.log("Error:"+result);
        //     }
        //   })();  
        // }  

        //Pagination start
       $scope.currentPage = PaginationServicee.currentPage;
       $scope.getPages = function(pageCount) {
           return PaginationServicee.getPages(pageCount);
       };

       $scope.switchPage = function(index) {
           var intervalID = setInterval(function(){
               if ($rootScope.xmlData.items.length > 0) {
                   if($scope.request) {
                       PaginationServicee.switchPage(index, $scope.reqQuery + '/search?' + buildQuery($scope.request)+ '&')
                           .then(function(data) {
                               $rootScope.xmlData = data.data;
                               $scope.currentPage = PaginationServicee.currentPage;
                       });
                   }  else if ($scope.searchingDone || $scope.searchingDone2) {
                       PaginationServicee.switchPage(index, $scope.reqQuery + '?option='+ $scope.searchType + '&value='+ $scope.requestSearch + "&page=" + index + "&per-page=" + constant.perPage)
                           .then(function(data) {
                               $rootScope.xmlData = data.data;
                               $scope.currentPage = PaginationServicee.currentPage;
                       });
                   } else {
                       PaginationServicee.switchPage(index, $scope.reqQuery + '?')
                           .then(function(data) {
                               $rootScope.xmlData = data.data;
                               $scope.currentPage = PaginationServicee.currentPage;
                       });
                   }    
                    clearInterval(intervalID);
               }
           },10);
       };
       $scope.switchPage($scope.currentPage);
       $scope.setPage = function(pageLink, pageType) {
           PaginationServicee.setPage(pageLink, pageType, $rootScope.xmlData._meta.pageCount)
               .then(function(data) {
                   $rootScope.xmlData = data.data;
                   $scope.currentPage = PaginationServicee.currentPage;
           });
       };
       //Pagination end
    }
})();