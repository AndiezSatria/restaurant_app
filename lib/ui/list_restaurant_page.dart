import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/widgets/restaurant_item_widget.dart';

class ListRestaurantPage extends StatefulWidget {
  const ListRestaurantPage({Key? key}) : super(key: key);

  @override
  State<ListRestaurantPage> createState() => _ListRestaurantPageState();
}

class _ListRestaurantPageState extends State<ListRestaurantPage> {
  String _searchText = "";
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildMainView(context)),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(child: _buildMainView(context)),
    );
  }

  Column _buildMainView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Restaurant",
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Recommendation restaurants for you!",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchText = value.trim();
              });
            },
            controller: _editingController,
            decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))),
          ),
        ),
        _buildFuture(context),
      ],
    );
  }

  FutureBuilder<String> _buildFuture(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurants.json'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          try {
            final List<Restaurant> listRestaurant =
                parseRestaurants(snapshot.data);
            final List<Restaurant> searchResult = (_searchText.isEmpty)
                ? <Restaurant>[]
                : listRestaurant
                    .where((element) => element.name
                        .toLowerCase()
                        .contains(_searchText.toLowerCase()))
                    .toList();
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: (searchResult.isEmpty)
                    ? listRestaurant.length
                    : searchResult.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      Navigator.pushNamed(
                        context,
                        RestaurantDetailPage.routeName,
                        arguments: (searchResult.isEmpty)
                            ? listRestaurant[index]
                            : searchResult[index],
                      );
                    },
                    child: RestaurantItemWidget(
                      restaurant: (searchResult.isEmpty)
                          ? listRestaurant[index]
                          : searchResult[index],
                    ),
                  );
                },
              ),
            );
          } catch (e) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
