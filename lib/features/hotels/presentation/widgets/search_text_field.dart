import 'package:flutter/material.dart';
import 'package:hotel_booking/core/integration_test_keys.dart';

import 'package:hotel_booking/i18n/strings.g.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        prefixIcon: SizedBox(
          width: 48,
          child: Icon(
            key:HotelsPageKeys.searchIcon,
            Icons.search
            ),
        ),
        suffixIcon: IconButton(
          onPressed: controller.clear,
          icon: Icon(
            key: HotelsPageKeys.clearSearchIcon,
            Icons.cancel_outlined),
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        hintText: t.hotels.search,
      ),
      style: textTheme.titleLarge,
      textInputAction: TextInputAction.search,
      onTapOutside: (_) => focusNode?.unfocus(),
    );
  }
}
