import 'dart:io';

import 'package:apiintegration/Helpers/APIHandlerHelper/APIHandlerHelper.dart';

import 'package:apiintegration/BO/AvengerBo/AvengerBO.dart';
import 'package:apiintegration/Helpers/AppConstants/AppConstants.dart';
import 'package:apiintegration/Helpers/Utitilites/Utilities.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'IAvengerService.dart';

import "package:dio/dio.dart";

// Create a class named AvengerService which implements the IAvengerService
class AvengerService implements IAvengerService {
  
  // Create an instance for the class Dio and pass the baseurl as a parameter to the constructor
  final Dio _dio =
      Dio(BaseOptions(baseUrl: AppConstants.avengerServiceBaseUrl));

  /* Create a method named createNewAvenger set the parameters nameofHero required*/
  @override
  Future<ServiceResult<AvengerBO>> createNewAvenger(
      {required AvengerBO nameOfHero}) async {
    
    // Create a try block    
    try {
    
      // Create variable named datatobeSent and serialize the nameofhero using the Jsonmapper and assign it to the variable
      var dataTobeSent = JsonMapper.serialize(nameOfHero);

      // Create a variable named responseFromServer and using the dio post method set the heroendpoint and give the data to it
      var responseFromServer = await _dio.post(
          AppConstants.avengerServiceCreateNewHeroEndPoint,
          data: dataTobeSent);

      // Check whether the responseFromServer status code is equal to 200
      if (responseFromServer.statusCode == 200) {
        
        // Return the serviceResult
        return ServiceResult(
          statusCode: HttpStatusCode.OK,
          message: "Success",
          content: JsonMapper.deserialize<AvengerBO>(responseFromServer.data),
        );
      }
      
      // Else condition not true
      else {
        
        // Return the serviceResult
        return ServiceResult(
          statusCode: HttpStatusCode.BadRequest,
          message: "Error",
          content: JsonMapper.deserialize<AvengerBO>(responseFromServer.data),
        );
      }
    }
    // Throws the exception when we give incorrect data
    on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        message: "The type of data got is incorrect!",
      );
    }
    
    // Throws the exception when there is weak internet connection
    on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        message: "There is not internet connection!",
      );
    }
    
    // Throws the system exception
    catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        message: e.toString(),
      );
    }
  }

  /* Create a method named deleteHeroFromAvenger pass the parameters */
  @override
  Future<ServiceResult<List<AvengerBO>>> deleteHeroFromAvenger(
      {required AvengerBO hero}) async {
    
    // Try the exception
    try {

      // Assign the variable named responseFromServer and using the dio delete method delete the endpoint with its id
      var resposeFromServer = await _dio.delete(
        "${AppConstants.avengerServiceEditHeroEndPoint}/${hero.id}",
      );

      // Check whether the responseFromServer status code is equal to 200
      if (resposeFromServer.statusCode == 200) {
        var content = resposeFromServer.data;
        List<AvengerBO> finalContent = [];
        if (content is List) {
          for (var element in content) {
            var instance = JsonMapper.deserialize<AvengerBO>(element);
            if (instance != null) {
              finalContent.add(instance);
            }
          }
        }

        // Return the serviceResult
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got Successfully");
      }

      // Return the serviceResult
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been got",
      );
    }

    // Throws the exception when we give incorrect data
    on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    }

    // Throws the exception when network is not proper
    on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is not internet connection!",
      );
    }

    // Throws the exception when we have system exception
    catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }

  /* Create a method named editNameOfAvenger pass a required parameter as hero */
  @override
  Future<ServiceResult<List<AvengerBO>>> editNameOfAvenger(
      {required AvengerBO hero}) async {
    try {
 
      // Assign the variable named result to the serialized jsonmapper
      var result = JsonMapper.serialize(hero);

      // Assign the variable named responseFromServer to the instance put
      var resposeFromServer = await _dio.put(
          "${AppConstants.avengerServiceEditHeroEndPoint}/${hero.id}",
          data: result);

      // Check whether the responseFromServer status code is equal to 200
      if (resposeFromServer.statusCode == 200) {
        var content = resposeFromServer.data;
        List<AvengerBO> finalContent = [];
        if (content is List) {
          for (var element in content) {
            var instance = JsonMapper.deserialize<AvengerBO>(element);
            if (instance != null) {
              finalContent.add(instance);
            }
          }
        }
      
        // Return the serviceResult
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got Successfully");
      }
      
      // Return the serviceResult
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been got",
      );
    }

    // Throws the exception when we give incorrect data
    on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    }

    // Throws the exception when network connectio is low
    on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is not internet connection!",
      );
    }

    // Throws the exception when we have system error
    catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }


  /* Create a method named getAllAvenger pass the parameters */
  @override
  Future<ServiceResult<List<AvengerBO>>> getAllAvengers() async {
    try {
      
      // Assign the variable named responseFromServer to the instance put
      var resposeFromServer =
          await _dio.get(AppConstants.avengerServiceGetAllAvengerEndPoint);
      
      // Check whether the responseFromServer status code is equal to 200
      if (resposeFromServer.statusCode == 200) {
        var content = resposeFromServer.data;
        List<AvengerBO> finalContent = [];
        if (content is List) {
          for (var element in content) {
            var instance = JsonMapper.deserialize<AvengerBO>(element);
            if (instance != null) {
              finalContent.add(instance);
            }
          }
        }

        // Return the serviceResult
        return ServiceResult(
            statusCode: HttpStatusCode.OK,
            content: finalContent,
            message: "Data got Successfully");
      }

      // Return the serviceResult
      return ServiceResult(
        statusCode: HttpStatusCode.Conflict,
        content: [],
        message: "Data has been got",
      );
    }

    // Throws the exception when we give incorrect data
    on FormatException {
      return ServiceResult(
        statusCode: HttpStatusCode.Forbidden,
        content: [],
        message: "The type of data got is incorrect!",
      );
    }

    // Throws the exception when network connection is low
    on SocketException {
      return ServiceResult(
        statusCode: HttpStatusCode.NetworkFailure,
        content: [],
        message: "There is not internet connection!",
      );
    }

    // Throws the exception when there is an system error
    catch (e) {
      e.writeExceptionData();
      return ServiceResult(
        statusCode: HttpStatusCode.SystemException,
        content: [],
        message: e.toString(),
      );
    }
  }
}
