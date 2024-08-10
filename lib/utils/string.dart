extension StringUtils on String {
  String stripHtmlIfNeeded() {
    return replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }
}
