import 'package:bloc_learning/constants/strings.dart';
import 'package:bloc_learning/data/models/qoutes.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<dynamic> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      return response.data;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<Quotes> getCharacterQuote(int id) async {
    try {
      Response response = await dio.get('quotes', queryParameters: {'id': id});
      return Quotes.fromJson(response.data);
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
