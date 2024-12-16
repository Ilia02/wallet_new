import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_new/features/presentation/theme/theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppThemes.lightTheme);

  void toggleTheme() {
    if (state.brightness == Brightness.light) {
      emit(AppThemes.darkTheme);
    } else {
      emit(AppThemes.lightTheme);
    }
  }
}
