import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../widgets/story_item.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram'),
        actions: const [
          Icon(Icons.favorite_border),
          SizedBox(width: 16),
          Icon(Icons.send_outlined),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        children: const [
          SizedBox(
            height: 110,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  StoryItem(
                    name: 'Você',
                    imagePath: 'assets/stories/history1.jpeg',
                  ),
                  StoryItem(
                    name: 'Ana',
                    imagePath: 'assets/stories/history2.jpeg',
                  ),
                  StoryItem(
                    name: 'Carlos',
                    imagePath: 'assets/stories/history3.jpeg',
                  ),
                  StoryItem(
                    name: 'Maria',
                    imagePath: 'assets/stories/history4.jpeg',
                  ),
                  StoryItem(
                    name: 'Pedro',
                    imagePath: 'assets/stories/history5.jpeg',
                  ),
                  StoryItem(
                    name: 'Julia',
                    imagePath: 'assets/stories/history6.jpeg',
                  ),
                  StoryItem(
                    name: 'Lucas',
                    imagePath: 'assets/stories/history7.jpeg',
                  ),
                ],
              ),
            ),
          ),

          Divider(height: 1),

          PostCard(
            username: 'flutter_dev',
            location: 'Curitiba - PR',
            caption: 'Meu primeiro post utilizando imagens no Flutter!',
            imagePath: 'assets/posts/post1.jpg',
            profileImage: 'assets/images/perfil1.jpeg',
          ),

          PostCard(
            username: 'mobile_ui',
            location: 'Brasil',
            caption: 'Projeto desenvolvido para a prova.',
            imagePath: 'assets/posts/post2.jpg',
            profileImage: 'assets/images/perfil2.jpeg',
          ),

          PostCard(
            username: 'design_ui',
            location: 'São Paulo - SP',
            caption: 'Interface inspirada no Instagram.',
            imagePath: 'assets/posts/post3.jpg',
            profileImage: 'assets/images/perfil3.jpeg',
          ),
        ],
      ),
    );
  }
}
