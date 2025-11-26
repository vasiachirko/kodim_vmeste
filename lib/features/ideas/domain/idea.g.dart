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
      authorId: fields[7] as String,
      tags: (fields[4] as List).cast<String>(),
      upvotes: fields[5] as int,
      downvotes: fields[6] as int,
      takenBy: fields[8] as String?,
      status: fields[9] as IdeaStatus,
      takenAt: fields[10] as DateTime?,
      completedAt: fields[11] as DateTime?,
      archived: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Idea obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.upvotes)
      ..writeByte(6)
      ..write(obj.downvotes)
      ..writeByte(7)
      ..write(obj.authorId)
      ..writeByte(8)
      ..write(obj.takenBy)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.takenAt)
      ..writeByte(11)
      ..write(obj.completedAt)
      ..writeByte(12)
      ..write(obj.archived);
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

class IdeaStatusAdapter extends TypeAdapter<IdeaStatus> {
  @override
  final int typeId = 1;

  @override
  IdeaStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return IdeaStatus.newIdea;
      case 1:
        return IdeaStatus.inProgress;
      case 2:
        return IdeaStatus.done;
      default:
        return IdeaStatus.newIdea;
    }
  }

  @override
  void write(BinaryWriter writer, IdeaStatus obj) {
    switch (obj) {
      case IdeaStatus.newIdea:
        writer.writeByte(0);
        break;
      case IdeaStatus.inProgress:
        writer.writeByte(1);
        break;
      case IdeaStatus.done:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdeaStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
