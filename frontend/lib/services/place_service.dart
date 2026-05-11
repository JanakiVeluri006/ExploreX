//  Fetches images for locations using external Unsplash API
//  Used by AddTripScreen to get a relevant image based on location input.

import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceService {

  static Future<String?> fetchPlaceImage(String place) async {
    try {
      final url =
          "https://api.unsplash.com/search/photos?query=$place&per_page=1&client_id=oPoi8fpxF1b39eDLurwvDtucS8_azrc85s7sh9rMWjE";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["results"] != null && data["results"].isNotEmpty) {
          return data["results"][0]["urls"]["regular"];
        }
      }
    } catch (e) {
      print("Unsplash Error: $e");
    }

    return null;
  }
}