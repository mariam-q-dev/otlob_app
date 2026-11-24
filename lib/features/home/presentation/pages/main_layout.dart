import 'package:flutter/material.dart';
import 'package:otlob_app/features/cart/presentation/pages/cart_screen.dart';
import 'package:otlob_app/features/explore/presentation/pages/explore_screen.dart';
import 'package:otlob_app/features/home/presentation/pages/home_screen.dart';
import 'package:otlob_app/features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:otlob_app/features/my_order/presentation/pages/order_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;


  final List<Widget> _screens = [
     HomeScreen(),            // Index 0: Home
    ExploreScreen(), // Index 1: Explore
     CartScreen(),            
    OrderScreen(),  // Index 3: Orders
    const Center(child: Text("Profile Screen")), // Index 4: Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; 
          });
        },
      ),
    );
  }
}