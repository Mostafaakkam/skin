import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:path/path.dart' show basename;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:skin/core/class/statusrequest.dart';

import '../functions/checkinternet.dart';
import 'cache_helper.dart'; // For Either type
class Crud {
  Future<Either<StatusRequest, String>> postData(String linkUrl, Map data) async {

    if (await checkInternet()) {
      try{
        var response = await http.post(Uri.parse(linkUrl), body: jsonEncode(data),  headers: {
        "Authorization":"Bearer ${CacheHelper.getData(key: "token")}"});
        print(response.statusCode) ;
          return Right(response.body);

      }catch(e){
        print("exception==========================$e");
        return const Left(StatusRequest.serverException);
      }

    } else {
      return const Left(StatusRequest.offlinefailure);
    }

  }

  Future<Either<StatusRequest, String>> getData(String linkUrl) async {


      if (await checkInternet()) {
        try{
          var response = await http.get(Uri.parse(linkUrl),headers: {
            "Authorization":"Bearer ${CacheHelper.getData(key: "token")}"});
          print(response.statusCode) ;

            print(response.body) ;

            return Right(response.body);

        }catch(e){
          return const Left(StatusRequest.serverException);
        }

      } else {
        return const Left(StatusRequest.offlinefailure);
      }
     
  }
  Future<Either<StatusRequest, String>> postMultiData(
      String url,Map data, File file,String fileKey) async {
    if (await checkInternet()) {
      try {
        var request = http.MultipartRequest("POST", Uri.parse(url));
  var length = await file.length();
  String fileName = basename(file.path);
  var stream = http.ByteStream(file.openRead());
  var multiPartFile = http.MultipartFile(fileKey, stream, length, filename: fileName);
        request.headers['Authorization'] = 'Bearer ${CacheHelper.getData(key: "token")}';
        request.files.add(multiPartFile);

        data.forEach((key, value) {
          request.fields[key] = value;
        });
        var myRequest = await request.send();
        var response = await http.Response.fromStream(myRequest);
        print(response.statusCode);
          print("Data is ${response.body}");
          return Right(response.body);
      } catch (e) {
        print("exception===========$e");
        return const Left(StatusRequest.serverException);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, String>> putMultiData(
      String url,Map data, File file,String fileKey) async {
    if (await checkInternet()) {
      try {
        var request = http.MultipartRequest("PUT", Uri.parse(url));
        var length = await file.length();
        String fileName = basename(file.path);
        var stream = http.ByteStream(file.openRead());
        var multiPartFile = http.MultipartFile(fileKey, stream, length, filename: fileName);
        request.headers['Authorization'] = 'Bearer ${CacheHelper.getData(key: "token")}';
        request.files.add(multiPartFile);

        data.forEach((key, value) {
          request.fields[key] = value;
        });
        var myRequest = await request.send();
        var response = await http.Response.fromStream(myRequest);
        print(response.statusCode);
        print("Data is ${response.body}");
        return Right(response.body);
      } catch (e) {
        print("exception===========$e");
        return const Left(StatusRequest.serverException);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
