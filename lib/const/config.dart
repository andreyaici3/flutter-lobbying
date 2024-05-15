class Config {
  Config._();
  //dev => untuk development
  //pub => untuk release
  static String ENVIRONTMENT = "pub";
  static String prefix = "v1";

  static String getUri() {
    if (ENVIRONTMENT == "dev") {
      return "http://192.168.1.4:8000/api/";
    } else {
      return "https://api-lobbying.andrey.id/api/";
    }
  }

  static String getDirectory() {
    if (ENVIRONTMENT == "dev") {
      String uri = getUri().replaceAll("api/", "storage/images/");
      return uri;
    } else {
      String uri = getUri().replaceAll("api/", "storage/images/");
      return uri;
    }
  }

  // ignore: non_constant_identifier_names
  static String URL_LOGIN = "${getUri() + prefix}/login";
  // ignore: non_constant_identifier_names
  static String URL_STORE_DATA = "${getUri() + prefix}/saveTrack";
  // ignore: non_constant_identifier_names
  static String URL_GET_DATA = "${getUri() + prefix}/getAll";
  // ignore: non_constant_identifier_names
  static String URL_GET_DATA_BY_id = "${getUri() + prefix}/getById/";
  // ignore: non_constant_identifier_names
  static String URL_UPDATE_DATA = "${getUri() + prefix}/updateTrack/";
  // ignore: non_constant_identifier_names
  static String URL_DELETE_DATA = "${getUri() + prefix}/delete/";
}
