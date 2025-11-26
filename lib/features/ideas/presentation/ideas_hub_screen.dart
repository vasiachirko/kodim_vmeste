import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kodim_vmeste/features/ideas/domain/idea.dart';
import 'package:kodim_vmeste/features/ideas/presentation/add_idea_screen.dart';
import 'package:kodim_vmeste/features/ideas/presentation/idea_detail_screen.dart';
import 'package:kodim_vmeste/features/ideas/presentation/idea_card.dart';
import 'package:kodim_vmeste/main.dart'; // ← убедись, что путь правильный

class IdeasHubScreen extends StatefulWidget {
  const IdeasHubScreen({super.key});
  @override State<IdeasHubScreen> createState() => _IdeasHubScreenState();
}

class _IdeasHubScreenState extends State<IdeasHubScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кодим вместе')),
      body: ValueListenableBuilder<Box<Idea>>(
        valueListenable: Hive.box<Idea>('ideas').listenable(),
        builder: (context, box, _) {
          final all = box.values.toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          List<Idea> ideas = [];

          if (_index == 0) {
            ideas = all.where((i) => !i.archived && i.status == IdeaStatus.newIdea).toList();
          } else if (_index == 1) {
            ideas = all.where((i) => i.authorId == CurrentUser.id && !i.archived).toList();
          } else {
            ideas = all.where((i) => i.authorId == CurrentUser.id && i.status == IdeaStatus.inProgress).toList();
          }

          if (ideas.isEmpty) {
            return Center(
              child: Text(
                _index == 0 ? 'Пока нет идей\nНажми + чтобы добавить' :
                _index == 1 ? 'Ты ещё ничего не создал' : 'Нет активных чатов',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: ideas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (_, i) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => IdeaDetailScreen(idea: ideas[i])),
              ),
              child: IdeaCard(idea: ideas[i]),
            ),
          );
        },
      ),
      floatingActionButton: (_index == 0 || _index == 1)
          ? FloatingActionButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddIdeaScreen()))
                  .then((_) => setState(() {})),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), label: 'Все идеи'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Мои идеи'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Чаты'),
        ],
      ),
    );
  }
}