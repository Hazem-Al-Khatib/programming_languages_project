import 'package:flutter/material.dart';
import 'rent_details_screen.dart';

class RentScreen extends StatelessWidget {
  const RentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          rentCard(
            context,
            title: "Apartment in City Center",
            location: "Damascus",
            price: "\$500 / month",
            imageUrl:
                "https://images.unsplash.com/photo-1502673530728-f79b4cab31b1",
          ),
          rentCard(
            context,
            title: "Modern Loft",
            location: "Aleppo",
            price: "\$600 / month",
            imageUrl:
                "https://images.unsplash.com/photo-1493809842364-78817add7ffb",
          ),
          rentCard(
            context,
            title: "Cozy Studio",
            location: "Homs",
            price: "\$350 / month",
            imageUrl:
                "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267",
          ),
        ],
      ),
    );
  }

  Widget rentCard(
    BuildContext context, {
    required String title,
    required String location,
    required String price,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RentDetailsScreen(
              title: title,
              location: location,
              price: price,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 50),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
