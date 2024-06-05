import 'package:flutter/material.dart';

class HowTo extends StatelessWidget {
  const HowTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 85,
                backgroundImage: AssetImage('assets/icons/location.png'),
              ),
            ),
            buildInstructionSection(
              icon: Icons.location_on,
              title: 'Nasıl Kullanılır',
              description:
                  '1. Öncelikle konumunuzun açık olduğundan emin olun.\n'
                  '2. Konumunuzu onaylayınız.\n'
                  '3. Yer alan seçeneklerden istediğinize erişin.\n'
                  '4. Favori bir yeriniz varsa bunu favorilere eklemeyi unutmayın!',
            ),
            const SizedBox(height: 20),
            buildInstructionSection(
                icon: Icons.info,
                title: 'Hazırlayanlar',
                description: 'Mahmut KELEŞ \nAbdulkadir ÖKSÜZ'),
          ],
        ),
      ),
    );
  }

  Widget buildInstructionSection({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(description),
      ],
    );
  }
}
