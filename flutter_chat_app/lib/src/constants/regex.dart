class RegexPattern {
  static final regexEmail =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static final regexPhone = RegExp(r"^0[0-9]{9}$");
}
