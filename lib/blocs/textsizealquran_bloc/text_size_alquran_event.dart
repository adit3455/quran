part of 'text_size_alquran_bloc.dart';

abstract class TextSizeAlquranEvent extends Equatable {
  const TextSizeAlquranEvent();

  @override
  List<Object> get props => [];
}

class ChangedSizeText extends TextSizeAlquranEvent {
  final String valueText;

  const ChangedSizeText(this.valueText);

  @override
  List<Object> get props => [valueText];
}
