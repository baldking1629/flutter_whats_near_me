import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_whats_near_me/theme/theme_provider.dart';
import 'package:provider/provider.dart';


Icon lightIcon = const Icon(CupertinoIcons.sun_max_fill);
Icon darkIcon = const Icon(CupertinoIcons.moon_fill);

IconButton myIconButton(context) {
  return IconButton(
    onPressed: () {
      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
    },
    icon: Provider.of<ThemeProvider>(context).isDarkMode ? lightIcon : darkIcon,
  );
}