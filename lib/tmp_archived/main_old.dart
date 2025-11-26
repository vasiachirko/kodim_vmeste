import 'package:flutter/material.dart';
import 'package:kodim_vmeste/features/ideas/presentation/add_idea_screen.dart';
import 'package:hive_flutter/hive_flutter.dart'; // ← ЭТА СТРОЧКА
import 'package:kodim_vmeste/features/ideas/domain/idea.dart';
import 'package:kodim_vmeste/features/ideas/presentation/ideas_hub_screen.dart';

void main_old() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(IdeaAdapter()); // наш новый адаптер
  await Hive.openBox<Idea>('ideas'); // новый бокс
  runApp(const MyApp());
}

class CurrentUser {
  static const String id = 'user-vasya-001';  // потом будет Firebase/Auth
  static const String name = 'Вася';
  static const UserRole role = UserRole.customer;  // пока заказчик
}

enum UserRole { customer, developer }

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
      home: const IdeasHubScreen(),
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
    upvotes: 24,
    downvotes: 2,
    authorId: 'user-vasya-001',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кодим вместе'),
        backgroundColor: Colors.deepPurple.shade50,
      ),
      body: ValueListenableBuilder<Box<Idea>>(
        valueListenable: Hive.box<Idea>('ideas').listenable(),
        builder: (context, box, _) {
          final ideas = box.values.toList()
            ..sort(
                (a, b) => b.createdAt.compareTo(a.createdAt)); // новые сверху

          if (ideas.isEmpty) {
            return const Center(
              child: Text(
                'Пока нет идей\nНажми + чтобы добавить',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: ideas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return IdeaCard(idea: ideas[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Просто открываем форму и ждём, когда пользователь вернётся
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddIdeaScreen(),
            ),
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
