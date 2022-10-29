import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onSearch;

  const SearchBar({this.controller, this.onSearch, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = controller ?? TextEditingController();

    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: ' Search tasks...',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontSize: 18,
        ),
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        suffixIcon: IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            onSearch?.call(searchController.text);
          },
        ),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 18),
      textInputAction: TextInputAction.search,
      cursorColor: Colors.white,
      maxLines: 1,
      onEditingComplete: () {
        onSearch?.call(searchController.text);
      },
    );
  }
}
