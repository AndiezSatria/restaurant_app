import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/menu_category.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    Key? key,
    required this.menuItem,
    this.menuCategory = MenuCategory.foods,
  }) : super(key: key);
  final Item menuItem;
  final MenuCategory menuCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: (menuCategory == MenuCategory.foods)
            ? terierColor
            : Colors.deepPurple,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Image.asset(
              (menuCategory == MenuCategory.foods)
                  ? "assets/images/dish.png"
                  : "assets/images/cocktail.png",
              width: 60,
            ),
          ),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                height: 45,
                padding: const EdgeInsets.all(16.0),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  menuItem.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.overline?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
