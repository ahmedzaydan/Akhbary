// ignore_for_file: avoid_print
import 'package:akhbary/modules/categories/categories_cubit/categories_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/remote/api_handler.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesInitialState());

  // return instance of cubit
  static CategoriesCubit getCategoriesCubit(context) {
    return BlocProvider.of(context);
  }

  String category = '';
  // change category
  void changeCategoryName({
    required String categoryName,
  }) {
    category = categoryName.toLowerCase(); // as categoryName comes from categoriesNames list
    getCategoryData();
    emit(ChangeCategoryNameState());
  }

  // categories list
  List<String> categoriesNames = [
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology',
    'General',
  ];

  Map<String, List<dynamic>> categoriesData = {
    'business': [],
    'entertainment': [],
    'health': [],
    'science': [],
    'sports': [],
    'technology': [],
    'general': [],
  };

  Map<String, List<CategoriesStates>> states = {
    'business': [
      GetBusinessLoadingState(),
      GetBusinessDataSuccessState(),
    ],
    'entertainment': [
      GetEntertainmentLoadingState(),
      GetEntertainmentDataSuccessState(),
    ],
    'health': [
      GetHealthLoadingState(),
      GetHealthDataSuccessState(),
    ],
    'science': [
      GetScienceLoadingState(),
      GetScienceDataSuccessState(),
    ],
    'sports': [
      GetSportsLoadingState(),
      GetSportsDataSuccessState(),
    ],
    'technology': [
      GetTechnologyLoadingState(),
      GetTechnologyDataSuccessState(),
    ],
    'general': [
      GetGeneralLoadingState(),
      GetGeneralDataSuccessState(),
    ],
  };

  // fill lists with data
  // get data from API using dio based on category value
  void getCategoryData({
    String country = 'eg',
    String language = 'ar',
  }) {
    emit(states[category]![0]);
    // if condition to get data only once
    if (categoriesData[category]!.isEmpty) {
      APIHandler.getDate(
        method: 'v2/top-headlines',
        queries: {
          'country': country,
          'language': language,
          'category': category,
          'apiKey': apiKey,
        },
      ).then((value) {
        categoriesData[category] = value.data['articles'];
        emit(states[category]![1]);
      }).catchError((error) {
        print(error.toString());
        switch (category) {
          case 'business':
            emit(GetBusinessDataErrorState(error));
            break;
          case 'entertainment':
            emit(GetEntertainmentDataErrorState(error));
            break;
          case 'health':
            emit(GetHealthDataErrorState(error));
            break;
          case 'science':
            emit(GetScienceDataErrorState(error));
            break;
          case 'sports':
            emit(GetSportsDataErrorState(error));
            break;
          case 'technology':
            emit(GetTechnologyDataErrorState(error));
            break;
          default:
            emit(GetGeneralDataErrorState(error));
            break;
        }
      });
    } else {
      emit(states[category]![1]);
    }
  }
}
