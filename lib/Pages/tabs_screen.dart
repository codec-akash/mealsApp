import 'package:flutter/material.dart';
import 'package:meals/Pages/categoriesPage.dart';
import 'package:meals/Pages/favouritesScreen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meals"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.stars),
                text: "Favorites",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CaterigoriesScreen(),
            // FavouritesScreen(), commented bcoz favorites need arguments
          ],
        ),
      ),
    );
  }
}
