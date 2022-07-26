import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;
  bool isDaytime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    var k = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
    Response response = await get(k);
    Map data = jsonDecode(response.body);
    // print(data);
    String datatime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    // print(datatime);
    // print(offset);
    DateTime now = DateTime.parse(datatime);
    now = now.add(Duration(hours: int.parse(offset)));
    isDaytime = now.hour > 6 && now.hour <  20 ? true : false;
    time = DateFormat.jm().format(now);
  }
}
