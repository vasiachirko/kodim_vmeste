// lib/features/ideas/domain/idea.dart
import 'package:hive/hive.dart';

part 'idea.g.dart';

enum IdeaStatus { lookingForDev, inProgress, done }
enum Difficulty { junior, middle, senior }
enum PreferredExperience { any, beginnerFriendly, wantsExperienced }

@HiveType(typeId: 0)
class Idea extends HiveObject {
  @HiveField(0)  String id;
  @HiveField(1)  String title;
  @HiveField(2)  String description;
  @HiveField(3)  DateTime createdAt;
  @HiveField(4)  List<String> tags;
  @HiveField(5)  Difficulty difficulty;
  @HiveField(6)  PreferredExperience preferredExperience;
  @HiveField(7)  String? city;
  @HiveField(8)  String? reward;
  @HiveField(9)  String? authorName;
  @HiveField(10) String? authorAvatarUrl;
  @HiveField(11) IdeaStatus status;
  @HiveField(12) int upvotes;
  @HiveField(13) int downvotes;
  @HiveField(14) String? developerId;

  Idea({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.tags,
    required this.difficulty,
    required this.preferredExperience,
    this.city,
    this.reward,
    this.authorName,
    this.authorAvatarUrl,
    this.status = IdeaStatus.lookingForDev,
    this.upvotes = 0,
    this.downvotes = 0,
    this.developerId,
  });

  // Удобный copyWith — чтобы не писать каждый раз новый объект
  Idea copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    List<String>? tags,
    Difficulty? difficulty,
    PreferredExperience? preferredExperience,
    String? city,
    String? reward,
    String? authorName,
    String? authorAvatarUrl,
    IdeaStatus? status,
    int? upvotes,
    int? downvotes,
    String? developerId,
  }) {
    return Idea(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
      difficulty: difficulty ?? this.difficulty,
      preferredExperience: preferredExperience ?? this.preferredExperience,
      city: city ?? this.city,
      reward: reward ?? this.reward,
      authorName: authorName ?? this.authorName,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
      status: status ?? this.status,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      developerId: developerId ?? this.developerId,
    );
  }
}