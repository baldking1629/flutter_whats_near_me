import 'package:flutter/material.dart';
import 'package:flutter_whats_near_me/services/favorities_services.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: FavoritesService().getFavoriteobjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<String>? favoriteObjects = snapshot.data;

              if (favoriteObjects == null || favoriteObjects.isEmpty) {
                return const Center(child: Text('Şimdilik Favori Mekan Yok !'));
              }

              return ListView.builder(
                itemCount: favoriteObjects.length,
                itemBuilder: (context, index) {
                  String objectName = favoriteObjects[index];

                  return ListTile(
                    title: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(objectName),
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
