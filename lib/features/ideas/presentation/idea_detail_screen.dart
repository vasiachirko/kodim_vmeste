import 'package:flutter/material.dart';
import '../domain/idea.dart';
import 'package:kodim_vmeste/main.dart';
class IdeaDetailScreen extends StatelessWidget {
  final Idea idea;
  const IdeaDetailScreen({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    final isAuthor = idea.authorId == CurrentUser.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Идея')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(idea.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(idea.description, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              if (idea.tags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: idea.tags.map((t) => Chip(label: Text('#$t'))).toList(),
                ),
              const Spacer(),
              // ← КНОПКА АРХИВИРОВАТЬ — теперь всегда внизу и красиво влезает
              if (isAuthor)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    icon: const Icon(Icons.archive, color: Colors.white),
                    label: const Text('Архивировать', style: TextStyle(fontSize: 18, color: Colors.white)),
                    onPressed: () async {
                      idea.archived = true;
                      await idea.save();
                      if (context.mounted) Navigator.pop(context);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}