import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_whats_near_me/constants/api.dart';
import 'package:flutter_whats_near_me/screens/object_detail_page.dart';
import 'package:flutter_whats_near_me/services/favorities_services.dart';
import 'package:flutter_whats_near_me/services/location_services.dart';
import 'package:flutter_whats_near_me/services/object_services.dart';
import 'package:geolocator/geolocator.dart';


class ObjectListPage extends StatefulWidget {
  final String? object;
  const ObjectListPage({Key? key, this.object}) : super(key: key);

  @override
  State<ObjectListPage> createState() => _HomePageState();
}

class _HomePageState extends State<ObjectListPage> {
  final String apiKey = Api.apiKey;
  late final ObjectService _objectService;
  late final LocationService _locationService;
  List<dynamic> objectList = [];
  List<dynamic> filteredobjects = [];

  @override
  void initState() {
    super.initState();
    _objectService = ObjectService(apiKey, widget.object!);
    _locationService = LocationService();
    _getLocationAndFetchobjects();
  }

  Future<void> _getLocationAndFetchobjects() async {
    try {
      Position position = await _locationService.getCurrentPosition();
      await _fetchNearbyobjects(position);
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
    }
  }

  Future<void> _fetchNearbyobjects(Position position) async {
    try {
      List<dynamic> nearbyobjects =
          await _objectService.fetchNearbyObjects(position);
      await _fetchobjectDetails(nearbyobjects);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching nearby objects: $e');
      }
    }
  }

  Future<void> _fetchobjectDetails(List<dynamic> places) async {
    try {
      List<dynamic> newobjectList = [];
      for (var place in places) {
        final placeId = place['place_id'];
        dynamic objectDetails =
            await _objectService.fetchObjectDetails(placeId);
        newobjectList.add(objectDetails);
      }
      if (mounted) {
        setState(() {
          objectList = newobjectList;
          filteredobjects = newobjectList;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching object details: $e');
      }
    }
  }

  Widget _buildobjectTile(dynamic object) {
    return FutureBuilder<List<String>>(
      future: FavoritesService().getFavoriteobjects(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            bool isFavorite = snapshot.data!.contains(object['name']);

            return Slidable(
              startActionPane:
                  ActionPane(motion: const BehindMotion(), children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      if (!isFavorite) {
                        FavoritesService().addFavorite(object);
                      }
                    });
                  },
                  icon: Icons.favorite,
                  foregroundColor: Colors.red,
                )
              ]),
              endActionPane:
                  ActionPane(motion: const BehindMotion(), children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      if (isFavorite) {
                        FavoritesService().removeFavorite(object);
                      }
                    });
                  },
                  icon: Icons.favorite,
                )
              ]),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ObjectDetailPage(object: object),
                    ),
                  );
                },
                title: Text(object['name']),
                leading: object['photoReference'] != ''
                    ? Image.network(
                        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${object['photoReference']}&key=$apiKey",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey,
                      ),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        FavoritesService().removeFavorite(object);
                      } else {
                        FavoritesService().addFavorite(object);
                      }
                    });
                  },
                ),
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Arama...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _updateFilteredobjects,
            ),
          ),
          Expanded(
            child: objectList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredobjects.length,
                    itemBuilder: (context, index) {
                      final object = filteredobjects[index];
                      return _buildobjectTile(
                          object); 
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _updateFilteredobjects(String query) {
    setState(() {
      filteredobjects = objectList
          .where((object) =>
              object['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
