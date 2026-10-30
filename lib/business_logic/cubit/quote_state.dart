part of 'quote_cubit.dart';

@immutable
sealed class QuoteState {}

final class QuoteInitial extends QuoteState {}
final class QuoteLoaded extends QuoteState {
  final Quotes quote;
  QuoteLoaded(this.quote);
}
