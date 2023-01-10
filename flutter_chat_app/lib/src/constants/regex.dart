class RegexPattern {
  static final regexEmail =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static final regexPhone = RegExp(r"/\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/");
}
