import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qoute_app_mobx/models/single_qoute.dart';

class QouteAPI {
  Future<List<SingleQoute>> fethQoutes() async {
    try {
      final response = await http.get(Uri.https('type.fit', '/api/quotes'));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        List<SingleQoute> convertedData =
            List.from(jsonResponse).map(
              (e) => SingleQoute.fromMap(e)).toList();
        return convertedData;
      } else {
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Something has went wrong $e');
      return [];
    }
  }
}
