import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/business/BusinessScreen.dart';
import '../../modules/science/ScienceScreen.dart';
import '../../modules/settings/SettingsScreen.dart';
import '../../modules/sports/SportsScreen.dart';
import '../components/constants.dart';
import '../network/local/cache_controller.dart';
import '../network/remote/api_handler.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState());

  static NewsCubit getNewsCubit(context) => BlocProvider.of(context);

  int currentScreenIndex = 0;

  // list of screens
  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  // business screen data
  List<dynamic> businessData = [];

  // get business data from API using dio
  void getBusinessData() {
    emit(GetBusinessLoadingState());
    // if condition to get data only once
    if (businessData.isEmpty) {
      APIHandler.getDate(
        method: 'v2/top-headlines',
        queries: {'country': 'eg', 'category': 'business', 'apiKey': apiKey},
      ).then((value) {
        businessData = value.data['articles'];
        emit(GetBusinessDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetBusinessDataErrorState(error));
      });
    } else {
      emit(GetBusinessDataSuccessState());
    }
  }

  // sports screen data
  List<dynamic> sportsData = [];

  // get sports data from API using dio
  void getSportsData() {
    emit(GetSportsLoadingState());
    // if condition here to get data only once
    if (sportsData.isEmpty) {
      APIHandler.getDate(
        method: 'v2/top-headlines',
        queries: {'country': 'eg', 'category': 'sports', 'apiKey': apiKey},
      ).then((value) {
        sportsData = value.data['articles'];
        emit(GetSportsDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetSportsDataErrorState(error));
      });
    } else {
      emit(GetSportsDataSuccessState());
    }
  }

  // science screen data
  List<dynamic> scienceData = [];

  // get business data from API using dio
  void getScienceData() {
    emit(GetScienceLoadingState());
    // if condition here to get data only once
    if (scienceData.isEmpty) {
      APIHandler.getDate(
        method: 'v2/top-headlines',
        queries: {'country': 'eg', 'category': 'science', 'apiKey': apiKey},
      ).then((value) {
        scienceData = value.data['articles'];
        emit(GetScienceDataSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetScienceDataErrorState(error));
      });
    } else {
      emit(GetScienceDataSuccessState());
    }
  }

  // change screen index
  void changeScreenIndex({required int index}) {
    currentScreenIndex = index;
    if (currentScreenIndex == 1) {
      getSportsData();
    } else if (currentScreenIndex == 2) {
      getScienceData();
    }
    emit(ChangeBottomNavBarIndexState());
  }

  // list bottom navbar items
  List<BottomNavigationBarItem> bottomItems = const [
    // business
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),

    // sports
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_volleyball),
      label: 'Sports',
    ),

    // science
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
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
