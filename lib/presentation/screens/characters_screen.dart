import 'package:bloc_learning/business_logic/character_cubit/character_cubit.dart';
import 'package:bloc_learning/constants/colors.dart';
import 'package:bloc_learning/data/models/character_model.dart';
import 'package:bloc_learning/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late Data allCharacters;
  late List<Character> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters.data!
        .where(
          (character) => character.name!.toLowerCase().startsWith(
            searchedCharacter.toLowerCase(),
          ),
        )
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: MyColors.myGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search, color: MyColors.myGrey),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacters = (state).data;
          return buildLoadedListWidget();
        } else {
          return const Center(
            child: CircularProgressIndicator(color: MyColors.myYellow),
          );
        }
      },
    );
  }

  Widget buildLoadedListWidget() {
    return Container(
      color: MyColors.myGrey,
      child: Column(children: [buildCharactersList()]),
    );
  }

  Widget buildCharactersList() {
    return Expanded(
      child: GridView.builder(
        itemCount: _searchTextController.text.isEmpty
            ? allCharacters.data!.length
            : searchedForCharacters.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),

        itemBuilder: (context, index) {
          print('Image URL: ${allCharacters.data?[index].imageUrl}');
          return CharacterItem(
            character: _searchTextController.text.isEmpty
                ? allCharacters.data![index]
                : searchedForCharacters[index],
          );
        },
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text('Characters', style: TextStyle(color: MyColors.myGrey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (context, connectivity, child) {
          final isOffline = connectivity.contains(ConnectivityResult.none);

          if (isOffline) {
            return buildNoInternetWidget();
          }

          return child;
        },
        child: buildBlocWidget(),
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            'No Internet Connection',
            style: TextStyle(fontSize: 18, color: MyColors.myGrey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                BlocProvider.of<CharacterCubit>(context).getAllCharacters();
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: MyColors.myYellow),
            child: const Text(
              'Retry',
              style: TextStyle(color: MyColors.myGrey),
            ),
          ),
        ],
      ),
    );
  }
}
