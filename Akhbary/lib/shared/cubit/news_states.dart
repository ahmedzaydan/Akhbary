abstract class NewsStates {}

class InitialState extends NewsStates {}


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
