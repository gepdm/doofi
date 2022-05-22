import 'package:doofi/api_accessor.dart';
import 'package:doofi/pages/generic_widgets.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar("Lista de alimentos"),
      drawer: const GlobalDrawer(),
      body: SafeArea(
        child: FutureBuilder(
          future: getFoodList(),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.done) {
              List<Food> foodList = data.data as List<Food>;
              return ListView.builder(
                itemCount: foodList.length,
                itemBuilder: (context, i) {
                  return FoodTile(foodList[i]);
                },
              );
            } else {
              return const Center(
                child: Text("Loading..."),
              );
            }
          },
        ),
      ),
    );
  }
}

class Food {
  final String _foodId;
  final String _foodName;
  final String _foodPrice;

  Food(this._foodId, this._foodName, this._foodPrice);
}

Future<List<Food>> getFoodList() async {
  dynamic foodJson = await ApiAccessor.requestFoods();
  List<Food> foodList = [];
  for (var food in foodJson) {
    foodList.add(Food(food["Id"], food["Name"], food["Price"]));
  }
  return foodList;
}

class FoodTile extends StatelessWidget {
  final Food _food;

  const FoodTile(this._food, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _food._foodName,
          textScaleFactor: 1.8,
        ),
        Image.network(
          "http://10.0.2.2:4000/api/public/foods/images/${_food._foodId}",
          width: 240,
          height: 240,
          fit: BoxFit.fill,
          frameBuilder: (context, image, frame, wasSyncLoaded) {
            if (wasSyncLoaded || frame != null) {
              return image;
            } else {
              return Container(height: 240, width: 240, color: Colors.grey);
            }
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Preco: R\$${NumberFormat.currency(locale: "pt_BR", name: "").format(num.parse(_food._foodPrice))}",
              textScaleFactor: 1.5,
            ),
            const SizedBox(
              width: 50,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Comprar"),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
