import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool canPop;
  final Widget? action;

  const BaseAppBar({super.key, required this.title, required this.canPop, this.action});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: canPop
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : const SizedBox.shrink(),
      title: Text(title),
      actions: action != null ? [action!] : [],
    );
  }
}
