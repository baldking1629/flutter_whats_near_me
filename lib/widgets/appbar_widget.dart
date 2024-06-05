import 'package:flutter/material.dart';
import 'package:flutter_whats_near_me/constants/app_colors.dart';
import 'package:flutter_whats_near_me/constants/my_actions_iconbutton.dart';
import 'package:flutter_whats_near_me/widgets/gradient_text_widget.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const GradientText(
        "What's Near Me",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontFamily: 'EmonaW00-Condensed'),
        gradient: LinearGradient(colors: [
          AppColors.secondaryColor,
          AppColors.quaternaryColor,
        ]),
      ),
      centerTitle: true,
      actions: [myIconButton(context)],
    );
  }
}
