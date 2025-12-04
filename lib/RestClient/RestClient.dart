import 'dart:convert';
import 'package:crud_with_rest_api/style/Style.dart';
import 'package:http/http.dart' as http;



Future<bool> ProductUpdateRequest(FormValue,id) async{
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/"+id);
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




Future<bool> ProductDeleteRequest(id) async{
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/"+id);
  var PostHeader ={"Content-Type":"application/json"};
 var response= await http.get(URL,headers: PostHeader);
  var ResultCode=response.statusCode;
  var ResultBoby=json.decode(response.body);
  if(ResultCode==200 && ResultBoby['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail ! try again");
  return false;
  }

}



Future <List> ProductGridViewListRequest () async
{
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var PostHeader ={"Content-Type":"application/json"};
  var response =await http.get(URL,headers: PostHeader);
  var ResultCode=response.statusCode;
  var ResultBoby=json.decode(response.body);
  if(ResultCode==200 && ResultBoby['status']=="success"){
    SuccessToast("Request Success");
    return ResultBoby['data'];
  }
  else{ ErrorToast("Request fail ! try again");
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

