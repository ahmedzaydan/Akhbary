// ignore_for_file: avoid_print

import 'package:akhbary/modules/bottom_navbar_screens/choose_category_screen.dart';
import 'package:akhbary/modules/bottom_navbar_screens/favorites_screen.dart';
import 'package:akhbary/modules/bottom_navbar_screens/read_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/bottom_navbar_screens/settings_screen.dart';
import '../components/constants.dart';
import '../network/local/cache_controller.dart';
import '../network/remote/api_handler.dart';
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
    const ChooseCategoryScreen(),
    const ReadScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  // list bottom navbar items
  List<BottomNavigationBarItem> bottomItems = [
    // categories
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.grid_view_sharp,
      ),
      label: 'Categories',
    ),

    // read
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.mark_chat_read,
      ),
      label: 'Read',
    ),

    // favorites
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.star,
      ),
      label: 'Favorites',
    ),

    // settings
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  bool darkMode = false;
  void setDarkMode({
    bool? darkModeParameter,
  }) {
    // if darkModeParameter is null 
    // then it is the start of the app so get the value cached
    if (darkModeParameter != null) {
      darkMode = darkModeParameter;
    } else {
      // otherwise we toggle the value of it and 
      // then cache the value after toggling it
      darkMode = !darkMode;
      CacheController.setBoolean(key: 'darkMode', value: darkMode);
    }
    emit(ChangeSwitchValueState());
  }

  // get data on search
  List<dynamic> searchData = [];
  void getSearchedData({
    required String query,
  }) {
    emit(SearchLoadingState());
    APIHandler.getDate(
      method: 'v2/everything',
      queries: {
        'q': query,
        'apiKey': apiKey,
      },
    ).then((value) {
      searchData = value.data['articles'];
      emit(GetSearchDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchDataErrorState(error));
    });
  }
}
