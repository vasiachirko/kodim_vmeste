// lib/features/ideas/domain/idea.dart

enum Difficulty { junior, middle, senior }
enum PreferredExperience { any, beginnerFriendly, wantsExperienced }

class Idea {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final List<String> tags;
  final Difficulty difficulty;
  final PreferredExperience preferredExperience;
  final String? city;
  final String? reward;
  final String? authorName;
  final int upvotes;
  final int downvotes;

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
    this.upvotes = 0,
    this.downvotes = 0,
  });

  // Удобный copyWith — будем использовать для голосования
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
    int? upvotes,
    int? downvotes,
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
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
    );
  }
}