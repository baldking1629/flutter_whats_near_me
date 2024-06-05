import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_whats_near_me/constants/app_colors.dart';
import 'package:flutter_whats_near_me/widgets/gradient_text_widget.dart';


class MyDrawer extends StatelessWidget {
  final void Function(int) onDrawerItemTap;
  final int selectedIndex;
  const MyDrawer({
    super.key,
    required this.onDrawerItemTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    onDrawerItemTap(0);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/icons/location.png',
                        width: 70,
                        height: 70,
                        color: AppColors.iconColor,
                      ),
                      const SizedBox(height: 2),
                      const GradientText(
                        "What's Near Me",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'EmonaW00-Condensed',
                        ),
                        gradient: LinearGradient(colors: [
                          AppColors.secondaryColor,
                          AppColors.quaternaryColor,
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text(
                'Çıkış Yap',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
