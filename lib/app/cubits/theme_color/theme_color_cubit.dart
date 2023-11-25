import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xox_app/app/cubits/theme_color/theme_color_state.dart';

class ThemeColorCubit extends Cubit<ThemeColorState> {
  ThemeColorCubit() : super(const ThemeColorState(isThemeLight: false));
  Future<void> changeThemeColor() async {
    if (state.isThemeLight != null) {
      emit(
        state.copyWith(isThemeLight: !state.isThemeLight!),
      );
    }
  }
}
