const blankValueError = 'این مقدار نمیتواند خالی باشد.';

String minValueError(int len) {
  return 'طول این مقدار نباید کمتر از $len کارکتر باشد.';
}

String maxValueError(int len) {
  return 'طول این مقدار نباید بیشتر از $len کارکتر باشد.';
}
