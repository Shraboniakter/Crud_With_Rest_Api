import 'dart:convert';

import 'package:crud_with_rest_api/style/Style.dart';
import 'package:http/http.dart' as http;

Future<List> ProductGridViewListRequest() async {
  var URL = Uri.parse("https://fab-book-info.vercel.app/books");
  var response = await http.get(URL);

  if (response.statusCode == 200) {
    SuccessToast("Request Success");
    return json.decode(response.body);
  } else {
    ErrorToast("Request failed");
    return [];
  }
}


Future<bool> ProductCreateRequest(FormValue) async{
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var PostBoby=json.encode(FormValue);
  var PostHeader ={"Content-Type":"application/json"};

 var response=await  http.post(URL,headers: PostHeader,body: PostBoby);
 var ResultCode=response.statusCode;
 var ResultBoby=json.decode(response.body);

if (ResultCode==200 && ResultBoby['status']=="success"){
  SuccessToast("Request Success");
  return true;
}
else{
  ErrorToast("Request fail ! try again");
  return false;
}

}

