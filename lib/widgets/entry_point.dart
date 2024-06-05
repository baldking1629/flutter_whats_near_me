import 'package:flutter/material.dart';
import 'package:flutter_whats_near_me/screens/favorites_page.dart';
import 'package:flutter_whats_near_me/screens/howto_page.dart';
import 'package:flutter_whats_near_me/screens/object_list_page.dart';
import 'package:flutter_whats_near_me/widgets/appbar_widget.dart';
import 'package:flutter_whats_near_me/widgets/drawer_widget.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class EntryPoint extends StatefulWidget {
  final String? object;
  const EntryPoint({Key? key, this.object}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  late int _selectedIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _parametersadd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: MyDrawer(
        selectedIndex: _selectedIndex,
        onDrawerItemTap: (index) {
          _parametersadd();
          _updateIndex(index);
        },
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            gap: 8,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              _updateIndex(index);
            },
            padding: const EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                onPressed: () {
                  _pages.add(ObjectListPage(
                    object: widget.object,
                  ));
                },
                text: 'Ana Sayfa',
              ),
              const GButton(
                icon: Icons.favorite_border,
                text: 'Favoriler',
              ),
              const GButton(
                icon: Icons.question_mark_sharp,
                text: 'Nasıl Çalışır',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _parametersadd() {
    _pages.add(ObjectListPage(
      object: widget.object,
    ));
    _pages.add(const FavoritesPage());
    _pages.add(const HowTo());
  }

  void _updateIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
