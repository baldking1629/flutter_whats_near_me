import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class ObjectService {
  final String apiKey;
  final String object;

  ObjectService(this.apiKey, this.object);

  Future<List<dynamic>> fetchNearbyObjects(Position position) async {
    LatLng location = LatLng(position.latitude, position.longitude);
    const radius = 1500;
    String type = object;
    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${location.latitude},${location.longitude}&radius=$radius&type=$type&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)["results"];
      return results;
    } else {
      throw Exception('Failed to load objects');
    }
  }

  Future<dynamic> fetchObjectDetails(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,formatted_address,photos&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = json.decode(response.body)["result"];
      final name = result['name'];
      final address = result['formatted_address'];
      String photoReference = "";

      if (result['photos'] != null && result['photos'].isNotEmpty) {
        photoReference = result['photos'][0]['photo_reference'];
      }

      return {
        'name': name,
        'address': address,
        'photoReference': photoReference,
      };
    } else {
      throw Exception('Failed to load object details');
    }
  }
}
