class Validators {
  static Function(String?) isNotEmpty = (String? value) {
    if(value == null || value.replaceAll(' ', '') == '') {
      return 'This field is required.';
    }
    return null;
  };

  static Function(String?) isValidEmail = (String? value) {
    RegExp regex = RegExp(r'^\s*?(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\s*?$');

    if (value!.isEmpty) {
      return null;
    }

    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address.';
    }

    return null;
  };
}