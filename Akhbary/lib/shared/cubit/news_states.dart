abstract class NewsStates {}

class InitialState extends NewsStates {}

// get business data states
class GetBusinessLoadingState extends NewsStates {}

class GetBusinessDataSuccessState extends NewsStates {}

class GetBusinessDataErrorState extends NewsStates {
  final String error;

  GetBusinessDataErrorState(this.error);
}

// get sports data states
class GetSportsLoadingState extends NewsStates {}

class GetSportsDataSuccessState extends NewsStates {}

class GetSportsDataErrorState extends NewsStates {
  final String error;

  GetSportsDataErrorState(this.error);
}

// get science data states
class GetScienceLoadingState extends NewsStates {}

class GetScienceDataSuccessState extends NewsStates {}

class GetScienceDataErrorState extends NewsStates {
  final String error;

  GetScienceDataErrorState(this.error);
}

// search states
class SearchLoadingState extends NewsStates {}

class GetSearchDataSuccessState extends NewsStates {}

class GetSearchDataErrorState extends NewsStates {
  final String error;

  GetSearchDataErrorState(this.error);
}

// settings states
class ChangeSwitchValueState extends NewsStates {}

// bottom nav bar states
class ChangeBottomNavBarIndexState extends NewsStates {}
