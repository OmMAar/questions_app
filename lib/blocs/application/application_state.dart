
class ApplicationState {
  // Current user language.
  final String? language;

  // // // Current user profile.
  // final UserSignInResult? user;


  ApplicationState({
    this.language,
    // this.user
  });

  ApplicationState copyWith({String? language,
    // UserSignInResult? user,
  }) =>
      ApplicationState(
        language: language ?? this.language,
        // user:  user ?? this.user,
      );

  ApplicationState clearProfile() {
    return ApplicationState(language: language,
        // user: user
    );
  }


  // UserSignInResult? get getUser => user;


  static ApplicationState get initialState => ApplicationState();
}
