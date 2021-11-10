class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://api.stackexchange.com/2.3";

  // receiveTimeout
  static const int receiveTimeout = 150000;

  // connectTimeout
  static const int connectionTimeout = 300000;

  /// user endPoint
  static const String userList = baseUrl + "/users";
  static const String questionList = baseUrl + "/questions";



}