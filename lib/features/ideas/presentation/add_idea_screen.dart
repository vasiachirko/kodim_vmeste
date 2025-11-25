// lib/features/ideas/presentation/add_idea_screen.dart
import 'package:flutter/material.dart';
import 'package:kodim_vmeste/features/ideas/domain/idea_try_new.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

class AddIdeaScreen extends StatefulWidget {
  const AddIdeaScreen({super.key});

  @override
  State<AddIdeaScreen> createState() => _AddIdeaScreenState();
}

class _AddIdeaScreenState extends State<AddIdeaScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _tagsController = TextEditingController();

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заполни заголовок и описание')),
      );
      return;
    }

    final idea = IdeaTryNew(
      id: const Uuid().v4(),
      title: title,
      description: desc,
      createdAt: DateTime.now(),
      tags: _tagsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
    );

    final box = Hive.box<IdeaTryNew>('ideas_try_new');
    await box.put(idea.id, idea);

    if (!mounted) return;
    Navigator.of(context).pop(); // просто возвращаемся
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая идея'),
        backgroundColor: Colors.deepPurple.shade50,
        foregroundColor: Colors.deepPurple.shade900,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Заголовок
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Заголовок',
              hintText: 'Например: Трекер привычек с напоминаниями',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              ),
            ),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
          const SizedBox(height: 20),

          // Описание
          TextField(
            controller: _descController,
            decoration: const InputDecoration(
              labelText: 'Описание',
              hintText: 'Подробно опиши, что хочешь сделать...',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              ),
            ),
            maxLines: 8,
          ),
          const SizedBox(height: 20),

          // Теги
          TextField(
            controller: _tagsController,
            decoration: const InputDecoration(
              labelText: 'Теги (через запятую)',
              hintText: 'flutter, продуктивность, напоминания',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Кнопка (пока просто закрывает форму)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Опубликовать', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
