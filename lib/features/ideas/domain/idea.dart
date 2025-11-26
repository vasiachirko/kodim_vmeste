// lib/features/ideas/domain/idea.dart

import 'package:hive/hive.dart';

part 'idea.g.dart';

@HiveType(typeId: 0)
class Idea extends HiveObject {
  @HiveField(0) final String id;
  @HiveField(1) final String title;
  @HiveField(2) final String description;
  @HiveField(3) final DateTime createdAt;
  @HiveField(4) final List<String> tags;
  @HiveField(5) final int upvotes;
  @HiveField(6) final int downvotes;
  @HiveField(7) String authorId; // ← обязательно
  @HiveField(8) String? takenBy; // ← может быть null
  @HiveField(9) IdeaStatus status; // ← обязательно
  @HiveField(10) DateTime? takenAt; // ← может быть null
  @HiveField(11) DateTime? completedAt; // ← может быть null
  @HiveField(12) bool archived; // ← обязательно

  Idea({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.authorId,
    this.tags = const [],
    this.upvotes = 0,
    this.downvotes = 0,
    this.takenBy,
    this.status = IdeaStatus.newIdea,
    this.takenAt,
    this.completedAt,
    this.archived = false,
  });
}

@HiveType(typeId: 1)
enum IdeaStatus {
  @HiveField(0) newIdea,
  @HiveField(1) inProgress,
  @HiveField(2) done,
}