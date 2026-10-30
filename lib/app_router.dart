import 'package:bloc_learning/business_logic/character_cubit/character_cubit.dart';
import 'package:bloc_learning/business_logic/cubit/quote_cubit.dart';
import 'package:bloc_learning/constants/strings.dart' as Strings;
import 'package:bloc_learning/data/models/character_model.dart';
import 'package:bloc_learning/data/repository/character_repo.dart';
import 'package:bloc_learning/data/web_servicies/characters_web_services.dart';
import 'package:bloc_learning/presentation/screens/characters_details_screen.dart';
import 'package:bloc_learning/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepo charactersRepo;
  late CharacterCubit characterCubit;

  AppRouter() {
    charactersRepo = CharactersRepo(CharactersWebServices());
    characterCubit = CharacterCubit(charactersRepo);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Strings.charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => characterCubit,
            child: const CharactersScreen(),
          ),
        );

      case Strings.characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => QuoteCubit(charactersRepo),
            child: CharactersDetailsScreen(character: character),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}
