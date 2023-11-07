class NetworkResponse{
final bool isSuccess;
final int statusCode;
final dynamic responseJson; // any type of data store
// final Map<String,dynamic>? responseJson;
NetworkResponse(this.isSuccess,this.statusCode,this.responseJson);
}