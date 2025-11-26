import 'package:flutter/material.dart';
import 'package:kodim_vmeste/features/ideas/domain/idea.dart';


class IdeaCard extends StatelessWidget {
  final Idea? idea;
  const IdeaCard({super.key, this.idea});

  // Заглушка — одна на всех
  static final Idea _fallbackIdea = Idea(
    id: 'fallback',
    title: 'Заглушка',
    description: 'Скоро здесь будут новые идеи',
    createdAt: DateTime(2025),
    tags: ['ожидание'],
    upvotes: 0,
    downvotes: 0,
    authorId: 'system',
  );

  @override
  Widget build(BuildContext context) {
    final i = idea ?? _fallbackIdea; 

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(i.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text(i.description, maxLines: 3, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: i.tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.deepPurple.shade50,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_upward, color: Colors.green, size: 20),
                  const SizedBox(width: 4),
                  Text('${i.upvotes}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  const Icon(Icons.arrow_downward, color: Colors.red, size: 20),
                  const SizedBox(width: 4),
                  Text('${i.downvotes}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}