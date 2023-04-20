abstract class CategoriesStates {}

class CategoriesInitialState extends CategoriesStates {}

// get business data states
class GetBusinessLoadingState extends CategoriesStates {}

class GetBusinessDataSuccessState extends CategoriesStates {}

class GetBusinessDataErrorState extends CategoriesStates {
  final String error;
  GetBusinessDataErrorState(this.error);
}

// get entertainment data states
class GetEntertainmentLoadingState extends CategoriesStates {}

class GetEntertainmentDataSuccessState extends CategoriesStates {}

class GetEntertainmentDataErrorState extends CategoriesStates {
  final String error;
  GetEntertainmentDataErrorState(this.error);
}

// get health data states
class GetHealthLoadingState extends CategoriesStates {}

class GetHealthDataSuccessState extends CategoriesStates {}

class GetHealthDataErrorState extends CategoriesStates {
  final String error;
  GetHealthDataErrorState(this.error);
}

// get science data states
class GetScienceLoadingState extends CategoriesStates {}

class GetScienceDataSuccessState extends CategoriesStates {}

class GetScienceDataErrorState extends CategoriesStates {
  final String error;
  GetScienceDataErrorState(this.error);
}

// get sports data states
class GetSportsLoadingState extends CategoriesStates {}

class GetSportsDataSuccessState extends CategoriesStates {}

class GetSportsDataErrorState extends CategoriesStates {
  final String error;
  GetSportsDataErrorState(this.error);
}

// get technology data states
class GetTechnologyLoadingState extends CategoriesStates {}

class GetTechnologyDataSuccessState extends CategoriesStates {}

class GetTechnologyDataErrorState extends CategoriesStates {
  final String error;
  GetTechnologyDataErrorState(this.error);
}

// get general data states
class GetGeneralLoadingState extends CategoriesStates {}

class GetGeneralDataSuccessState extends CategoriesStates {}

class GetGeneralDataErrorState extends CategoriesStates {
  final String error;
  GetGeneralDataErrorState(this.error);
}

class ChangeCategoryNameState extends CategoriesStates {}
