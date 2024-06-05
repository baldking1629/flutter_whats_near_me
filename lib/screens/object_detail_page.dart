import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whats_near_me/constants/api.dart';


class ObjectDetailPage extends StatelessWidget {
  final Map<String, dynamic> object;

  const ObjectDetailPage({Key? key, required this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(object['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            object['photoReference'] != ''
                ? DropShadowImage(
                    image: Image.network(
                      "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${object['photoReference']}&key=${Api.apiKey}",
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: 18,
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    scale: 1.03,
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.grey,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  ),
            const SizedBox(height: 20),
            Text(
              '${object['name']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Address: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${object['address'] ?? 'No address'}',
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
