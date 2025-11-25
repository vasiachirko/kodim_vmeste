import 'package:flutter/material.dart';
import 'package:kodim_vmeste/features/ideas/domain/idea.dart'; // ← добавь импорт!

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кодим вместе',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IdeasScreen(),
    );
  }
}

class IdeasScreen extends StatelessWidget {
  const IdeasScreen({super.key});

  // Одна настоящая идея — вручную
  static final Idea testIdea = Idea(
    id: '1',
    title: 'Трекер привычек с напоминаниями в 21:00',
    description:
        'Хочу простое приложение без рекламы. Главное — пуш в 21:00, если не отметил выполнение',
    createdAt: DateTime(2025, 4, 5),
    tags: ['flutter', 'напоминания', 'продуктивность'],
    difficulty: Difficulty.junior,
    preferredExperience: PreferredExperience.beginnerFriendly,
    city: 'Москва',
    reward: 'Пицца',
    authorName: 'Вася',
    upvotes: 24,
    downvotes: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кодим вместе'),
        backgroundColor: Colors.deepPurple.shade50,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          IdeaCard(idea: IdeasScreen.testIdea), // берём из static const
          const SizedBox(height: 16),
          const IdeaCard(),
          const SizedBox(height: 16),
          const IdeaCard(),
          const SizedBox(height: 16),
          const IdeaCard(),
          const SizedBox(height: 16),
          const IdeaCard(),
          const SizedBox(height: 80), // отступ под FAB
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Скоро будет форма добавления!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Обновлённая карточка — теперь принимает Idea
class IdeaCard extends StatelessWidget {
  final Idea? idea;
  const IdeaCard({super.key, this.idea});

  static final Idea _fallback = Idea(
    id: '',
    title: 'Заглушка',
    description: 'Скоро здесь будут новые идеи',
    createdAt: DateTime(2025),
    tags: ['ожидание'],
    difficulty: Difficulty.junior,
    preferredExperience: PreferredExperience.any,
  );

  @override
  Widget build(BuildContext context) {
    final i = idea ?? _fallback;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            Text(
              i.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),

            // Описание
            Text(
              i.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 12),

            // Теги
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: i.tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: Colors.deepPurple.shade50,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        labelPadding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Только голоса — в правом нижнем углу
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_upward, color: Colors.green, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${i.upvotes}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
