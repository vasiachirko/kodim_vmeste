import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kodim_vmeste/features/ideas/domain/idea.dart';
import 'package:kodim_vmeste/features/ideas/presentation/add_idea_screen.dart';
import 'package:kodim_vmeste/features/ideas/presentation/idea_card.dart';
import 'package:kodim_vmeste/features/ideas/presentation/ideas_hub_screen.dart';


// ─────── ТЕКУЩИЙ ПОЛЬЗОВАТЕЛЬ (пока захардкодим) ───────
class CurrentUser {
  static const String id = 'vasya-001';
  static const String name = 'Вася';
  static const UserRole role = UserRole.customer; // ← потом переключатель
}

enum UserRole { customer, developer }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(IdeaAdapter());
  Hive.registerAdapter(IdeaStatusAdapter());

  await Hive.openBox<Idea>('ideas');

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
      home: const IdeasHubScreen(),
    );
  }
}

class IdeasScreen extends StatelessWidget {
  const IdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кодим вместе')),
      body: ValueListenableBuilder<Box<Idea>>(
        valueListenable: Hive.box<Idea>('ideas').listenable(),
        builder: (context, box, _) {
          final ideas = box.values.toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          if (ideas.isEmpty) {
            return const Center(
              child: Text('Пока нет идей\nНажми + чтобы добавить', textAlign: TextAlign.center),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: ideas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) => IdeaCard(idea: ideas[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddIdeaScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}