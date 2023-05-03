import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'text_size_alquran_event.dart';
part 'text_size_alquran_state.dart';

class TextSizeAlquranBloc
    extends Bloc<TextSizeAlquranEvent, TextSizeAlquranState> {
  String? selectedValue = 'kecil';
  TextSizeAlquranBloc() : super(const TextSizeAlquran()) {
    on<ChangedSizeText>((event, emit) {
      selectedValue = event.valueText;
      emit(TextSizeAlquran(
          selectedValue: selectedValue,
          value: (selectedValue == 'kecil')
              ? 15
              : (selectedValue == 'normal')
                  ? 20
                  : 35));
    });
  }
}
