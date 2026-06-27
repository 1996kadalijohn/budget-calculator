import 'package:flutter/material.dart' as material;

class CustomAppBar extends material.StatelessWidget implements material.PreferredSizeWidget {
  final String title;
  final List<material.Widget>? actions;
  final material.Widget? leading;
  final bool centerTitle;
  final material.Color? backgroundColor;
  final material.Color? foregroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  material.Widget build(material.BuildContext context) {
    return material.AppBar(
      title: material.Text(title),
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }

  @override
  material.Size get preferredSize => const material.Size.fromHeight(material.kToolbarHeight);
}
