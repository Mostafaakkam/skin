
import 'dart:io';

import '../../../core/class/crud.dart';
import '../../../linkapi.dart';

class AppData {
  Crud crud;
  AppData(this.crud);
  getData(String url) async {
    var response = await crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }
  postData(String url,Map body) async {
    var response = await crud.postData(url,body);
    return response.fold((l) => l, (r) => r);
  }
  postMultiData(String url,File file,Map data,String fileKey) async {
    var response = await crud.postMultiData(url, data,file,fileKey);
    return response.fold((l) => l, (r) => r);
  }
  putMultiData(String url,File file,Map data,String fileKey) async {
    var response = await crud.putMultiData(url, data,file,fileKey);
    return response.fold((l) => l, (r) => r);
  }

}
