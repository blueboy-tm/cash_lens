import 'errors.dart' as errors;

class TextInputValidator {
  final bool blank;
  final bool trim;
  final int? minLength;
  final int? maxLength;

  TextInputValidator({
    this.blank = false,
    this.trim = true,
    this.minLength,
    this.maxLength,
  }) : assert(true);

  String? validator(String? value) {
    value ??= '';
    if (trim) {
      value = value.trim();
    }
    if (!blank && (trim ? value.trim().isEmpty : value.isEmpty)) {
      return errors.blankValueError;
    }
    if (minLength != null && minLength! > value.length) {
      return errors.minValueError(minLength!);
    }
    if (maxLength != null && maxLength! < value.length) {
      return errors.maxValueError(maxLength!);
    }
    return null;
  }
}
