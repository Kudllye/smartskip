import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SettingsButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingsButtonWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: CustomIconWidget(
          iconName: 'settings',
          color: AppTheme.textMediumEmphasisLight,
          size: 6.w,
        ),
        padding: EdgeInsets.all(3.w),
      ),
    );
  }
}
