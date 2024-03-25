// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_01/providers/customers_provider.dart';
import 'package:shopping_01/providers/products_provider.dart';
import 'package:shopping_01/screens/customer_screen.dart';
import 'package:shopping_01/screens/product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // list of items
  List<Widget> gridItemList = [
    GridItem(iconData: Icons.groups_rounded, text: "Customers"),
    GridItem(iconData: Icons.shopping_cart_checkout_sharp, text: "Products"),
    GridItem(iconData: Icons.add_chart, text: "New Order"),
    GridItem(iconData: Icons.keyboard_return_rounded, text: "Return Order"),
    GridItem(iconData: Icons.attach_money, text: "Add Payment"),
    GridItem(iconData: Icons.playlist_add_check, text: "Today's Order"),
    GridItem(iconData: Icons.description, text: "Today's Summery"),
    GridItem(iconData: Icons.route, text: "Route"),
  ];

  void onTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CustomerScreen(),
        ),
      );
    } else if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProductScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.getProductFromAPI();
    CustomersProvider customersProvider =
        Provider.of<CustomersProvider>(context, listen: false);
    customersProvider.getCustomersFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile.jpg"),
          ),
        ),
        actions: const [
          Image(
            image: AssetImage("assets/icons/menu-bar.png"),
            height: 40,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 8,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.17,
        ),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        itemCount: gridItemList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              onTapped(context, index);
            },
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.indigo[800],
            child: gridItemList[index],
          );
        },
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  GridItem({super.key, required this.iconData, required this.text});
  IconData iconData;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 40,
            color: Colors.indigo[800],
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
