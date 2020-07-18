import 'package:flutter/material.dart';
import 'package:meals/widgets/categoryItem.dart';

import '../dummy_data.dart';

class CaterigoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      children: DUMMY_CATEGORIES
          .map(
            (e) => CategoryItem(
              e.id,
              e.title,
              e.color,
            ),
          )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
    );
  }
}
