import 'package:http/http.dart' as http;

class Networking {
  final String url;

  Networking(this.url);

  Future<dynamic> getWeatherData() async {
    // var weatherData
    final request = await http.get(Uri.parse(url));

    if (request.statusCode == 200) {
      var response = request.body;
      return response;
    } else {
      print('Error');
      return "";
    }
  }
}
