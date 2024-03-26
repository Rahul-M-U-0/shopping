import 'package:flutter/material.dart';
import 'package:shopping_01/screens/customer_screen.dart';
import 'package:shopping_01/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.transparent,

        backgroundColor: Colors.white,
        //elevation: 2,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.indigo,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Colors.indigo,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add_chart_sharp,
              color: Colors.indigo,
            ),
            label: 'New Order',
          ),
          NavigationDestination(
            icon: Badge(
              backgroundColor: Colors.indigo,
              label: Text('2'),
              child: Icon(
                Icons.production_quantity_limits,
                color: Colors.indigo,
              ),
            ),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.keyboard_return_outlined,
              color: Colors.indigo,
            ),
            label: 'Return Order',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.groups_rounded,
              color: Colors.indigo,
            ),
            label: 'Customers',
          )
        ],
      ),
      body: [
        const HomeScreen(),
        const Center(
          child: Icon(
            Icons.add_chart_sharp,
            color: Colors.indigo,
            size: 50,
          ),
        ),
        const Center(
          child: Icon(
            Icons.production_quantity_limits,
            color: Colors.indigo,
            size: 50,
          ),
        ),
        const Center(
          child: Icon(
            Icons.keyboard_return_outlined,
            color: Colors.indigo,
            size: 50,
          ),
        ),
        CustomerScreen(),
      ][currentPageIndex],
    );
  }
}
