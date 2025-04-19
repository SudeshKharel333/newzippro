class InputValidators {
  static String? mobileNumberValidator(String? mobileNumber) {
    // r'(^(?:[+0]9)?[0-9]{10,12}$)'
    if (mobileNumber != null &&
        RegExp(r'(\+977)?[9][6-9]\d{8}').hasMatch(mobileNumber) &&
        mobileNumber.length == 10) {
      return null;
    }
    return "Please enter valid phone number";
  }

  static String? emailValidator(String? email) {
    if (email != null &&
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(email)) {
      return null;
    }
    return 'Invalid email address';
  }

  static String? passwordValidator(String? password) {
    //If the password doesn't match the regular expression, it returns 'Password should contain upper, lower, digit and Special character'.
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (password == null) {
      return 'Please enter password';
    } else {
      if (password.length <= 7) {
        return 'Password Must be more than 8 characters';
      } else if (!regex.hasMatch(password)) {
        return 'Password should contain upper,lower,digit and Special character ';
      } else {
        return null;
      }
    }

    // if (password == null ||
    //     password.length <= 6 ||
    //     !password.containesDigit() || !password.contains("")) {
    //   return 'Atleast 8 characters with number';
    // }
    // return null;
  }

  static String? confirmPasswordValidator(
      String? password, String? confirmPassword) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (password == null) {
      return 'Please enter password';
    } else {
      if (password.length <= 7) {
        return 'Password Must be more than 7 characters';
      } else if (!regex.hasMatch(password)) {
        return 'Password should contain upper,lower,digit and Special character ';
      } else if (password != confirmPassword) {
        return "password does not match";
      } else {
        return null;
      }
    }

    // if (password == null ||
    //     password.length <= 7||
    //     !password.containesDigit()) {
    //   return 'Atleast 8 characters with 1 number';
    // } else if (password != confirmPassword) {
    //   return "password does not match";
    // }
    // return null;
  }

  static String? nameValidation(String? value) {
    if (value == null || value == '') {
      return "Please enter your name";
    }
    if (value.length < 3 || value.length > 60) {
      return "must contain atleast 3 characters";
    }
    return null;
  }

  static String? simpleValidation(String? value) {
    if (value == null || value == '') {
      return "Required *";
    }

    return null;
  }

  static String? simpleValidationWithMinLength(String? value, int length) {
    if (value == null || value == '') {
      return "Required *";
    } else if (value.length < length) {
      return "Minimum of $length characters are required ";
    }
    return null;
  }
}
