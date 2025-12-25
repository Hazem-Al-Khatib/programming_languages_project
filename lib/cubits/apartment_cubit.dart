import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pl_project/cubits/apartment_state.dart';
import '../models/apartment.dart';

class ApartmentCubit extends Cubit<ApartmentState> {
  ApartmentCubit() : super(ApartmentInitial());

  void fetchApartments() async {
    emit(ApartmentLoading());
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      List<Apartment> apartments = [
        Apartment(
          name: "Green Villa",
          city: "Cairo",
          price: 2500,
          imageUrl: 'assets/images/house.png',
        ),
        Apartment(
          name: "Sunny Apartment",
          city: "Alexandria",
          price: 1800,
          imageUrl: 'assets/images/house.png',
        ),
        Apartment(
          name: "Sea View Flat",
          city: "Hurghada",
          price: 3000,
          imageUrl: 'assets/images/house.png',
        ),
      ];
      emit(ApartmentLoaded(apartments));
    } catch (e) {
      emit(ApartmentError("Failed to load apartments"));
    }
  }
}
