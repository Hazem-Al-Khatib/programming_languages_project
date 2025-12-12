// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pl_project/screens/apartment_details_screen.dart';
import '../models/apartment.dart';

class ApartmentCard extends StatelessWidget {
  final Apartment apartment;

  const ApartmentCard({required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(apartment.name),
        subtitle: Text('${apartment.city} - \$${apartment.price.toString()}'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ApartmentDetailsScreen()),
          );
        },
      ),
    );
  }
}
