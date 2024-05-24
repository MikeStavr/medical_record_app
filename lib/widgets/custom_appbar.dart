import "package:flutter/material.dart";

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    this.bottomWidget,
  });

  final String title;
  final PreferredSizeWidget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottomWidget,
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 77, 216, 235),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
