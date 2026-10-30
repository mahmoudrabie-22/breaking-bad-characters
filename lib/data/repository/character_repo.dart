import 'package:bloc_learning/data/models/character_model.dart';
import 'package:bloc_learning/data/models/qoutes.dart' hide Data;
import 'package:bloc_learning/data/web_servicies/characters_web_services.dart';

class CharactersRepo {
  final CharactersWebServices charactersWebServices;
  CharactersRepo(this.charactersWebServices);
  Future<Data> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return Data.fromJson(characters);
  }

  Future<Quotes> getCharacterQuote(int id) async {
    final quotes = await charactersWebServices.getCharacterQuote(id);

    return quotes.data!.isNotEmpty
        ? Quotes.fromJson(quotes.toJson())
        : Quotes(success: false, data: []);
  }
}
