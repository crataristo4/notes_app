class ApiReXponse<T> {
  T data;
  bool error;
  String errorMessage;

  ApiReXponse({this.data, this.errorMessage, this.error = false});
}