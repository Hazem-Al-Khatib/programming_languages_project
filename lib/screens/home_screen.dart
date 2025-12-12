// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_project/cubits/apartment_state.dart';
import '../cubits/bottom_nav_cubit.dart';
import '../cubits/apartment_cubit.dart';
import '../widgets/apartment_card.dart';
import 'rent_screen.dart';
import 'history_screen.dart';
import 'rating_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider(create: (_) => ApartmentCubit()..fetchApartments()),
      ],
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, currentIndex) {
          List<Widget> pages = [
            _buildHomePage(),
            RentScreen(),
            HistoryScreen(),
            RatingScreen(),
            SettingsScreen(),
          ];

          return Scaffold(
            body: pages[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: TextStyle(color: Colors.black),
              selectedFontSize: 20,
              fixedColor: Colors.blue,
              currentIndex: currentIndex,
              onTap: (index) =>
                  context.read<BottomNavCubit>().changeIndex(index),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Rent',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  label: 'Rating',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHomePage() {
    return BlocBuilder<ApartmentCubit, ApartmentState>(
      builder: (context, state) {
        if (state is ApartmentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ApartmentLoaded) {
          return ListView.builder(
            itemCount: state.apartments.length,
            itemBuilder: (_, index) {
              return ApartmentCard(apartment: state.apartments[index]);
            },
          );
        } else if (state is ApartmentError) {
          return Center(child: Text(state.error));
        }
        return Center(child: Text('Welcome!'));
      },
    );
  }
}
