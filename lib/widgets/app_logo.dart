import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final String title;

  const AppLogo({
    super.key,
    this.size = 72,
    this.title = 'Budget Calculator',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.account_balance_wallet,
            size: size * 0.6,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
