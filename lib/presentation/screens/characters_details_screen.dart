import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_learning/business_logic/cubit/quote_cubit.dart';
import 'package:bloc_learning/constants/colors.dart';
import 'package:bloc_learning/data/models/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      foregroundColor: MyColors.myWhite,
      expandedHeight: 600,
      pinned: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name!,
          style: const TextStyle(color: MyColors.myWhite, fontSize: 16),
        ),
        background: Hero(
          tag: character.id!,
          child: Image.network(character.imageUrl!, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildCharacterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: MyColors.myWhite, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuoteCubit>(context).getCharacterQuote(character.id!);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCharacterInfo(
                      'Job : ',
                      character.occupation!.join(' / '),
                    ),
                    buildDivider(315),
                    buildCharacterInfo('Appeared in : ', character.series!),
                    buildDivider(250),
                    buildCharacterInfo(
                      'Seasons : ',
                      character.appearances!.join(' / '),
                    ),
                    buildDivider(280),
                    buildCharacterInfo('Status : ', character.fullName!),
                    buildDivider(300),
                    buildCharacterInfo(
                      'Actor/Actress : ',
                      character.portrayed!,
                    ),
                    buildDivider(230),
                    const SizedBox(height: 20),

                    BlocBuilder<QuoteCubit, QuoteState>(
                      builder: (context, state) {
                        if (state is QuoteLoaded) {
                          return checkIfQuoteIsLoaded(state);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: MyColors.myYellow,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 500),
            ]),
          ),
        ],
      ),
    );
  }

  Widget checkIfQuoteIsLoaded(QuoteLoaded state) {
    if (state.quote.data!.isNotEmpty) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return Center(
        child: const CircularProgressIndicator(color: MyColors.myYellow),
      );
    }
  }

  Widget displayRandomQuoteOrEmptySpace(QuoteLoaded state) {
    var quote = state.quote;
    if (quote.data!.isNotEmpty) {
      int randomIndex = Random().nextInt(quote.data!.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quote.data![randomIndex].quote!),
            ],
            totalRepeatCount: 1,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
