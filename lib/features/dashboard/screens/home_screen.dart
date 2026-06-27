import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dashboard_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dashboardProvider = context.watch<DashboardProvider>();
    final progressValue = (dashboardProvider.expense / dashboardProvider.budget).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLow,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello John 👋',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Your budget is looking healthy today.',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(Icons.person, color: theme.colorScheme.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Budget Overview',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              DashboardSummaryCard(
                title: 'Budget',
                subtitle: 'Monthly goal',
                amount: '₹${dashboardProvider.budget.toInt().toString()}',
                color: theme.colorScheme.primary,
                isPrimary: true,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DashboardSummaryCard(
                      title: 'Income',
                      subtitle: 'Expected',
                      amount: '₹${dashboardProvider.income.toInt().toString()}',
                      color: const Color(0xFF16A34A),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardSummaryCard(
                      title: 'Expense',
                      subtitle: 'Spent',
                      amount: '₹${dashboardProvider.expense.toInt().toString()}',
                      color: const Color(0xFFDC2626),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DashboardSummaryCard(
                title: 'Savings',
                subtitle: 'Remaining balance',
                amount: '₹${dashboardProvider.savings.toInt().toString()}',
                color: const Color(0xFF16A34A),
                fullWidth: true,
              ),
              const SizedBox(height: 24),
              Text(
                'Recent Transactions',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              _TransactionTile(
                title: 'Salary',
                subtitle: 'Today · Income',
                amount: '+₹20,000',
                amountColor: const Color(0xFF16A34A),
              ),
              _TransactionTile(
                title: 'Groceries',
                subtitle: 'Yesterday · Expense',
                amount: '-₹1,200',
                amountColor: const Color(0xFFDC2626),
              ),
              _TransactionTile(
                title: 'Freelance',
                subtitle: '2 days ago · Income',
                amount: '+₹8,500',
                amountColor: const Color(0xFF16A34A),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Budget Progress', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                        Text(
                          '${dashboardProvider.spentPercentage.toStringAsFixed(0)}%',
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        minHeight: 10,
                        color: theme.colorScheme.primary,
                        backgroundColor: theme.colorScheme.surfaceContainerHigh,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Spent so far', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                        Text('Budget left', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardSummaryCard extends StatelessWidget {
  const DashboardSummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.subtitle,
    this.fullWidth = false,
    this.isPrimary = false,
  });

  final String title;
  final String amount;
  final Color color;
  final String subtitle;
  final bool fullWidth;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      elevation: isPrimary ? 2 : 0,
      color: isPrimary ? color : theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: EdgeInsets.all(isPrimary ? 20 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isPrimary ? Colors.white : theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isPrimary ? Colors.white70 : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              amount,
              style: TextStyle(
                color: isPrimary ? Colors.white : color,
                fontWeight: FontWeight.w700,
                fontSize: isPrimary ? 24 : 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.amountColor,
  });

  final String title;
  final String subtitle;
  final String amount;
  final Color amountColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: amountColor.withValues(alpha: 0.12),
              child: Icon(Icons.swap_horiz, color: amountColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            Text(amount, style: theme.textTheme.bodyMedium?.copyWith(color: amountColor, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
