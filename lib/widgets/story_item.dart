import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String name;
  final String? imagePath;

  const StoryItem({super.key, required this.name, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.pink,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: imagePath != null
                  ? AssetImage(imagePath!)
                  : null,
              child: imagePath == null
                  ? const Icon(Icons.person, color: Colors.black)
                  : null,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
