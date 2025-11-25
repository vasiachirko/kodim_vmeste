// lib/features/ideas/domain/idea_try_new.dart
import 'package:hive/hive.dart';

part 'idea.g.dart';

@HiveType(typeId: 0)  // 0 занят Idea, берём 1
class Idea extends HiveObject {
  @HiveField(0) final String id;
  @HiveField(1) final String title;
  @HiveField(2) final String description;
  @HiveField(3) final DateTime createdAt;
  @HiveField(4) final List<String> tags;
  @HiveField(5) final int upvotes;
  @HiveField(6) final int downvotes;

  Idea({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.tags = const [],
    this.upvotes = 0,
    this.downvotes = 0,
  });
}