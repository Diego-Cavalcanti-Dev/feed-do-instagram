import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String username;
  final String location;
  final String caption;
  final String imagePath;
  final String profileImage;
  final int likes;
  final bool initiallyLiked;
  final List<String> comments;

  const PostCard({
    super.key,
    required this.username,
    required this.location,
    required this.caption,
    required this.imagePath,
    required this.profileImage,
    this.likes = 0,
    this.initiallyLiked = false,
    this.comments = const [],
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool _isLiked;
  late int _likesCount;
  late List<String> _comments;
  bool _showHeartOverlay = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initiallyLiked;
    _likesCount = widget.likes;
    _comments = List<String>.from(widget.comments);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likesCount += _isLiked ? 1 : -1;
    });
  }

  void _handleImageDoubleTap() {
    if (!_isLiked) {
      _toggleLike();
    }
    setState(() {
      _showHeartOverlay = true;
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _showHeartOverlay = false;
        });
      }
    });
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _comments.add(text);
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: AssetImage(widget.profileImage),
                  onBackgroundImageError: (_, __) {
                    debugPrint(
                      'Erro ao carregar imagem de perfil: ${widget.profileImage}',
                    );
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert),
              ],
            ),
          ),

          // Imagem
          GestureDetector(
            onDoubleTap: _handleImageDoubleTap,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  widget.imagePath,
                  width: double.infinity,
                  height: 320,
                  fit: BoxFit.cover,
                ),
                AnimatedOpacity(
                  opacity: _showHeartOverlay ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white70,
                    size: 100,
                  ),
                ),
              ],
            ),
          ),

          // Botões
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  onPressed: _toggleLike,
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 28,
                    color: _isLiked ? Colors.red : null,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.chat_bubble_outline, size: 28),
                const SizedBox(width: 16),
                const Icon(Icons.send_outlined, size: 28),
                const Spacer(),
                const Icon(Icons.bookmark_border, size: 28),
              ],
            ),
          ),

          // Curtidas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Curtido por $_likesCount pessoas",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 6),

          // Legenda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: "${widget.username} ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.caption),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          if (_comments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _comments.length == 1
                    ? '1 comentário'
                    : 'Ver todos ${_comments.length} comentários',
                style: const TextStyle(color: Colors.grey),
              ),
            ),

          for (final comment in _comments)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: _buildCommentSpans(comment),
                ),
              ),
            ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Adicione um comentário...',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _addComment(),
                  ),
                ),
                IconButton(
                  onPressed: _addComment,
                  icon: const Icon(Icons.send, size: 20),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }

  List<TextSpan> _buildCommentSpans(String comment) {
    final parts = comment.split(':');
    if (parts.length >= 2) {
      return [
        TextSpan(
          text: '${parts[0]}: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: parts.sublist(1).join(':').trim()),
      ];
    }
    return [TextSpan(text: comment)];
  }
}
