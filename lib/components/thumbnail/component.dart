import 'package:flutter/material.dart';

class Thumbnail extends StatelessWidget {
  final String imageUrl;

  const Thumbnail({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Set width of the container
      height: 100, // Set height of the container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Apply border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 2, // Blur radius
            offset: const Offset(0, 3), // Offset of the shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(8), // Clip the image with border radius
        child: Image.network(
          imageUrl,
          fit: BoxFit
              .cover, // Adjust how the image is displayed within the container
        ),
      ),
    );
  }
}
