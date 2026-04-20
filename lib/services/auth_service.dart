class AuthService {
  static String currentUserName = 'NomePadrao';
  static String currentUserRa = '5555555';

  static bool login({required String email, required String password}) {
    return email.trim().isNotEmpty && password.trim().isNotEmpty;
  }

  static bool register({
    required String name,
    required String ra,
    required String email,
    required String password,
  }) {
    if (name.trim().isEmpty ||
        ra.trim().isEmpty ||
        email.trim().isEmpty ||
        password.trim().isEmpty) {
      return false;
    }

    currentUserName = name.trim();
    currentUserRa = ra.trim();
    return true;
  }
}
