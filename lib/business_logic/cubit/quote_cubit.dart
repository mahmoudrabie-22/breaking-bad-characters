import 'package:bloc/bloc.dart';
import 'package:bloc_learning/data/models/qoutes.dart';
import 'package:bloc_learning/data/repository/character_repo.dart';
import 'package:meta/meta.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  CharactersRepo characterRepo;
  QuoteCubit(this.characterRepo) : super(QuoteInitial());

  Future<void> getCharacterQuote(int id) async {
    characterRepo.getCharacterQuote(id).then((quote) {
      emit(QuoteLoaded(quote));
    });
  }
}
