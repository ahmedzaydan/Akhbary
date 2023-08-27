// ignore_for_file: avoid_print
import 'package:akhbary/models/article_model.dart';
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
    category = categoryName
        .toLowerCase(); // as categoryName comes from categoriesNames list
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

  Map<String, List<ArticleModel>> categoriesData = {
    'business': [],
    'entertainment': [],
    'health': [],
    'science': [],
    'sports': [],
    'technology': [],
    'general': [],
  };

  List<ArticleModel> readData = [];

  List<ArticleModel> favoritesData = [];

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
      APIHandler.getData(
        method: 'v2/top-headlines',
        queries: {
          'country': country,
          'language': language,
          'category': category,
          'apiKey': apiKey,
        },
      ).then((value) {
        // parse each article and map it
        List<dynamic> list = value.data['articles'];
        for (var article in list) {
          ArticleModel articleModel = ArticleModel.mapArticleToModel(
            article: article,
            articleCategory: category,
          );
          categoriesData[category]!.add(articleModel);
        }
        // categoriesData[category] = value.data['articles'];
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

  void markArticleRead({
    required int articleID,
    required String articleCategory,
  }) {
    ArticleModel articleModel = categoriesData[articleCategory]!
        .firstWhere((article) => article.id == articleID);
    if (!readData.any((article) => article.id == articleModel.id)) {
      readData.add(articleModel);
    }
    articleModel.read = !articleModel.read;
    if (articleModel.read == false) {
      readData.remove(articleModel);
    }
    emit(MarkArticleReadState());
  }

  void addArticleToFavorites({
    required int articleID,
    required String articleCategory,
  }) {
    ArticleModel articleModel = categoriesData[articleCategory]!
        .firstWhere((article) => article.id == articleID);
    if (!favoritesData.any((article) => article.id == articleModel.id)) {
      favoritesData.add(articleModel);
    }
    articleModel.favorites = !articleModel.favorites;
    if (articleModel.favorites == false) {
      favoritesData.remove(articleModel);
    }
    emit(AddToFavoritesState());
  }
}
