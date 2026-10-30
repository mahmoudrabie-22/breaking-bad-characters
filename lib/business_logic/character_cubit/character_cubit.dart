import 'package:bloc/bloc.dart';
import 'package:bloc_learning/data/models/character_model.dart';
import 'package:bloc_learning/data/repository/character_repo.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharactersRepo charactersRepo;
  CharacterCubit(this.charactersRepo) : super(CharacterInitial());
  Future<void> getAllCharacters() async {
    try {
      emit(CharacterInitial());
      final characters = await charactersRepo.getAllCharacters();
      emit(CharacterLoaded(characters));
    } catch (error) {
      Exception(error.toString());
    }
  }
}
