import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          HistoryCard(
            title: "Apartment in City Center",
            date: "12 Dec 2025",
            status: "Approved",
            image: "https://via.placeholder.com/150",
          ),
          HistoryCard(
            title: "House with Garden",
            date: "5 Dec 2025",
            status: "Pending",
            image: "https://via.placeholder.com/150",
          ),
          HistoryCard(
            title: "Studio Near University",
            date: "28 Nov 2025",
            status: "Rejected",
            image: "https://via.placeholder.com/150",
          ),
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final String image;

  const HistoryCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.image,
  });

  Color getStatusColor() {
    switch (status) {
      case "Approved":
        return Colors.green;
      case "Pending":
        return Colors.orange;
      case "Rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: 
            Container(
  width: 110,
  height: 110,
  decoration: BoxDecoration(
    color: Colors.grey.shade300,
    borderRadius: const BorderRadius.horizontal(
      left: Radius.circular(12),
    ),
  ),
  child: const Icon(
    Icons.home,
    size: 40,
    color: Colors.grey,
  ),
),

          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: getStatusColor().withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: getStatusColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
