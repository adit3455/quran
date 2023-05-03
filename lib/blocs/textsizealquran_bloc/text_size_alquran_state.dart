part of 'text_size_alquran_bloc.dart';

abstract class TextSizeAlquranState extends Equatable {
  const TextSizeAlquranState();

  @override
  List<Object?> get props => [];
}

class TextSizeAlquran extends TextSizeAlquranState {
  final String? selectedValue;
  final double? value;
  const TextSizeAlquran({this.value, this.selectedValue});

  @override
  List<Object?> get props => [value, selectedValue];
}
