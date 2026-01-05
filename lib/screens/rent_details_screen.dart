import 'package:flutter/material.dart';

class RentDetailsScreen extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String imageUrl;

  const RentDetailsScreen({
    super.key,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(imageUrl),
            const SizedBox(height: 10),
            Text(
              location,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              price,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
