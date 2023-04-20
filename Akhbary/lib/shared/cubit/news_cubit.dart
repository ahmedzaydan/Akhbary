// ignore_for_file: avoid_print

import 'package:akhbary/modules/categories/choose_category_screen.dart';
import 'package:akhbary/modules/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/settings_screen.dart';
import '../network/local/cache_controller.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState());

  static NewsCubit getNewsCubit(context) {
    return BlocProvider.of(context);
  }

  int currentScreenIndex = 0;

  // change screen index
  void changeScreenIndex({
    required int index,
  }) {
    currentScreenIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }

  // list of screens
  List<Widget> screens = [
    const HomeScreen(),
    const ChooseCategoryScreen(),
    const SettingsScreen(),
  ];

  // list bottom navbar items
  List<BottomNavigationBarItem> bottomItems = const [
    // home
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),

    // categories
    BottomNavigationBarItem(
      icon: Icon(
        Icons.grid_view_sharp,
      ),
      label: 'Categories',
    ),
    // settings
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  bool switchValue = false;

  void setSwitchValue({
    bool? darkMode,
  }) {
    // if switchVal is null then it is the start of the app so get the value cached
    if (darkMode != null) {
      switchValue = darkMode;
    } else {
      // otherwise we toggle the value of it and then cache the value after toggling it
      switchValue = !switchValue;
      CacheController.setBoolean(key: 'switchValue', value: switchValue);
    }
    emit(ChangeSwitchValueState());
  }

  // get data on search
  List<dynamic> searchData = [];

  // void getSearchedData({
  //   required String query,
  // }) {
  //   emit(SearchLoadingState());
  //   APIHandler.getDate(
  //     method: 'v2/everything',
  //     queries: {
  //       'q': query,
  //       'apiKey': apiKey,
  //     },
  //   ).then((value) {
  //     searchData = value.data['articles'];
  //     emit(GetSearchDataSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetSearchDataErrorState(error));
  //   });
  // }
}
