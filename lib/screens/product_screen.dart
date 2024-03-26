import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shopping_01/models/products.dart';
import 'package:shopping_01/providers/products_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Nesto Hypermarcket",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SearchField(),
            Consumer<ProductsProvider>(
              builder: (context, providerValue, child) {
                return providerValue.isLoading
                    ? productsLoadingUI(context)
                    : providerValue.error.isNotEmpty
                        ? productsErrorUI(providerValue.error, context)
                        : productsBodyUI(context, providerValue.products);
              },
            ),
          ],
        ),
      ),
    );
  }

  //product loading
  Widget productsLoadingUI(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          SpinKitFadingCircle(
            color: Colors.indigo[800],
            size: 60,
          ),
          Text(
            "Loading...",
            style: TextStyle(
              fontSize: 18,
              color: Colors.indigo[800],
            ),
          ),
        ],
      ),
    );
  }

  //product error Ui
  Widget productsErrorUI(String error, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.53,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          error,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  //product body
  Expanded productsBodyUI(BuildContext context, Products products) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 8,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.18,
        ),
        padding: const EdgeInsets.symmetric(vertical: 25),
        itemCount: products.data.length,
        itemBuilder: (context, index) {
          return gridPoductItem(
            products,
            index,
            context,
          );
        },
      ),
    );
  }

  //product item
  Widget gridPoductItem(Products products, int index, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      "http://143.198.61.94${products.data[index].image}"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products.data[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${products.data[index].price.toString()}/-",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 1.5,
                  height: MediaQuery.of(context).size.height * 0.04,
                  color: Colors.grey.shade400,
                ),
                InkWell(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.035,
                    width: MediaQuery.of(context).size.width * 0.135,
                    decoration: BoxDecoration(
                      color: Colors.indigo[800],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//searchfield
class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.qrcode,
                color: Colors.grey,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: VerticalDivider(
                  color: Colors.grey.shade400,
                  thickness: 1.5,
                ),
              ),
              const Text(
                "Fruits",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
