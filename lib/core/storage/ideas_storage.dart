// lib/core/storage/ideas_storage.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kodim_vmeste/features/ideas/domain/idea.dart';

class IdeasStorage {
  static const boxName = 'ideas';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(IdeaAdapter());
    await Hive.openBox<Idea>(boxName);
  }

  static Box<Idea> get box => Hive.box<Idea>(boxName);

  static List<Idea> getAll() => box.values.toList()
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  static Future<void> add(Idea idea) async {
    await box.put(idea.id, idea);
  }
}