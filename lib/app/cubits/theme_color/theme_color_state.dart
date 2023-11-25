import 'package:equatable/equatable.dart';

class ThemeColorState extends Equatable {
  const ThemeColorState({this.isThemeLight});
  final bool? isThemeLight;
  
  ThemeColorState copyWith({
    bool? isThemeLight,
  }) {
    return ThemeColorState(
      isThemeLight: isThemeLight ?? this.isThemeLight,
    );
  }

  @override
  List<Object?> get props => [
        isThemeLight,
      ];
}
