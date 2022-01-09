import 'dart:convert';

class ListRestaurant {
  late List<Restaurant> restaurants;

  ListRestaurant({required this.restaurants});

  ListRestaurant.fromJson(Map<String, dynamic> restaurantsData) {
    final restaurantsJson = restaurantsData['restaurants'] as List<dynamic>?;
    restaurants = restaurantsJson != null
        ? restaurantsJson
            .map((restaurantData) => Restaurant.fromJson(restaurantData))
            .toList()
        : <Restaurant>[];
  }
}

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late String rating;
  late Menu menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'];
    menus = Menu.fromJson(restaurant['menus']);
  }
}

class Menu {
  late List<Item> foods;
  late List<Item> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  Menu.fromJson(Map<String, dynamic> menu) {
    final menuFoodItems = menu['foods'] as List<dynamic>?;
    final menuDrinkItems = menu['drinks'] as List<dynamic>?;
    foods = menuFoodItems != null
        ? menuFoodItems.map((itemData) => Item.fromJson(itemData)).toList()
        : <Item>[];
    drinks = menuDrinkItems != null
        ? menuDrinkItems.map((itemData) => Item.fromJson(itemData)).toList()
        : <Item>[];
  }
}

class Item {
  late String name;

  Item({required this.name});

  Item.fromJson(Map<String, dynamic> item) {
    name = item['name'];
  }
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }
  final parsed = jsonDecode(json);
  final ListRestaurant restaurants = ListRestaurant.fromJson(parsed);
  return restaurants.restaurants;
}
