// lib/core/storage/ideas_try_new_storage.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kodim_vmeste/features/ideas/domain/idea_try_new.dart';

class IdeasTryNewStorage {
  static const boxName = 'ideas_try_new';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(IdeaTryNewAdapter());
    await Hive.openBox<IdeaTryNew>(boxName);
  }

  static Box<IdeaTryNew> get box => Hive.box<IdeaTryNew>(boxName);

  static List<IdeaTryNew> getAll() => box.values.toList()
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  static Future<void> add(IdeaTryNew idea) async {
    await box.put(idea.id, idea);
  }
}