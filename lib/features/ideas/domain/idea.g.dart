// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdeaAdapter extends TypeAdapter<Idea> {
  @override
  final int typeId = 0;

  @override
  Idea read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Idea(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      createdAt: fields[3] as DateTime,
      tags: (fields[4] as List).cast<String>(),
      difficulty: fields[5] as Difficulty,
      preferredExperience: fields[6] as PreferredExperience,
      city: fields[7] as String?,
      reward: fields[8] as String?,
      authorName: fields[9] as String?,
      authorAvatarUrl: fields[10] as String?,
      status: fields[11] as IdeaStatus,
      upvotes: fields[12] as int,
      downvotes: fields[13] as int,
      developerId: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Idea obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.tags)
      ..writeByte(5)
      ..write(obj.difficulty)
      ..writeByte(6)
      ..write(obj.preferredExperience)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.reward)
      ..writeByte(9)
      ..write(obj.authorName)
      ..writeByte(10)
      ..write(obj.authorAvatarUrl)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.upvotes)
      ..writeByte(13)
      ..write(obj.downvotes)
      ..writeByte(14)
      ..write(obj.developerId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdeaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
