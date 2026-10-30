part of 'character_cubit.dart';

sealed class CharacterState {}

final class CharacterInitial extends CharacterState {}

final class CharacterLoaded extends CharacterState {
  final Data data;
  CharacterLoaded(this.data);
}
