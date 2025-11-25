// lib/features/ideas/domain/idea_try_new.dart
import 'package:hive/hive.dart';
import 'package:kodim_vmeste/features/ideas/domain/idea.dart';

part 'idea_try_new.g.dart';

@HiveType(typeId: 1)  // 0 занят Idea, берём 1
class IdeaTryNew extends HiveObject {
  @HiveField(0) final String id;
  @HiveField(1) final String title;
  @HiveField(2) final String description;
  @HiveField(3) final DateTime createdAt;
  @HiveField(4) final List<String> tags;
  @HiveField(5) final int upvotes;
  @HiveField(6) final int downvotes;

  IdeaTryNew({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.tags = const [],
    this.upvotes = 0,
    this.downvotes = 0,
  });

  // Удобно — можно скопировать из старой Idea
  factory IdeaTryNew.fromIdea(Idea old) => IdeaTryNew(
        id: old.id,
        title: old.title,
        description: old.description,
        createdAt: old.createdAt,
        tags: old.tags,
        upvotes: old.upvotes,
        downvotes: old.downvotes,
      );
}