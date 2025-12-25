import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_project/cubits/bottom_nav_cubit.dart';
import 'package:pl_project/widgets/bottom_nav_bar.dart'; // Ensure this matches your filename
import 'package:pl_project/widgets/home_screen_widgets.dart';

import 'rent_screen.dart';
import 'history_screen.dart';
import 'rating_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Wrap EVERYTHING in BlocProvider
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: BlocBuilder<BottomNavCubit, int>(
            builder: (context, state) {
              const titles = ['Home', 'Rent', 'History', 'Rating', 'Settings'];
              return Text(
                titles[state],
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          centerTitle: true,
        ),
        // 2. The BlocBuilder should provide the context needed for the pages
        body: BlocBuilder<BottomNavCubit, int>(
          builder: (context, currentIndex) {
            // Move pages list here so it can use the 'context' from BlocProvider
            final List<Widget> pages = [
              _buildStaticHomeContent(),
              RentScreen(),
              HistoryScreen(),
              RatingScreen(),
              SettingsScreen(),
            ];

            return pages[currentIndex];
          },
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
      ),
    );
  }

  Widget _buildStaticHomeContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text(
          "Recommended for you: ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16),
        HomePageCard(
          imageUrl: "assets/images/house.png",
          price: "\$1,200 / month",
          address: "123 Modern Ave, Downtown",
        ),
        SizedBox(height: 12),
        HomePageCard(
          imageUrl: "assets/images/house.png",
          price: "\$950 / month",
          address: "456 Quiet St, Suburbs",
        ),
        SizedBox(height: 16),
        HomePageCard(
          imageUrl: "assets/images/house.png",
          price: "\$1,200 / month",
          address: "123 Modern Ave, Downtown",
        ),
      ],
    );
  }
}
