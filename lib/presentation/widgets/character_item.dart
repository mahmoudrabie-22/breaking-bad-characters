import 'package:bloc_learning/constants/colors.dart';
import 'package:bloc_learning/constants/strings.dart' as Strings;
import 'package:bloc_learning/data/models/character_model.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({required this.character, super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Strings.characterDetailsScreen,
            arguments: character,
          );
        },
        child: GridTile(
          footer: Hero(
            tag: character.id!,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${character.name}',
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          child: Container(
            color: MyColors.myGrey,
            child: character.imageUrl!.isNotEmpty
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: character.imageUrl!,
                    fit: BoxFit.cover,
                  )
                : Image.asset('assets/images/loading.gif'),
          ),
        ),
      ),
    );
  }
}
