import 'package:flutter/material.dart';
import 'package:flutter_web_pagination/flutter_web_pagination.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    super.key,
    required this.total,
    required this.initial,
    required this.onPageChanged,
  });
  final int total;
  final int initial;
  final Function(int page) onPageChanged;

  @override
  Widget build(BuildContext context) {
    if (total <= 1) {
      return const SizedBox.shrink();
    }
    return WebPagination(
      displayItemCount: 3,
      onPageChanged: onPageChanged,
      currentPage: initial,
      totalPage: total,
    );
  }
}
