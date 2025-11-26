// lib/features/ideas/presentation/ideas_screen.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kodim_vmeste/features/ideas/domain/idea.dart';
import 'package:kodim_vmeste/features/ideas/presentation/add_idea_screen.dart';

class IdeasScreen extends StatelessWidget {
  const IdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кодим вместе')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Idea>('ideas').listenable(),
        builder: (context, box, _) {
          final ideas = box.values.toList();

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Количество идей в Hive:', style: TextStyle(fontSize: 20)),
                Text(
                  '${ideas.length}',
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Добавляем одну тестовую идею прямо из экрана
                    final testIdea = Idea(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: 'Тестовая идея',
                      description: 'Это тест',
                      createdAt: DateTime.now(),
                      authorId: 'test-user',
                    );
                    box.put(testIdea.id, testIdea);
                  },
                  child: const Text('Добавить тестовую идею'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => box.clear(),
                  child: const Text('Очистить всё'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddIdeaScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}