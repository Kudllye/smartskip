import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ServiceStatusIndicator extends StatelessWidget {
  final bool isServiceActive;
  final bool isProcessing;

  const ServiceStatusIndicator({
    Key? key,
    required this.isServiceActive,
    required this.isProcessing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12.w,
      height: 12.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getStatusColor(),
        boxShadow: [
          BoxShadow(
            color: _getStatusColor().withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: isProcessing
          ? Padding(
              padding: EdgeInsets.all(2.w),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.lightTheme.colorScheme.surface,
                ),
              ),
            )
          : null,
    );
  }

  Color _getStatusColor() {
    if (isProcessing) {
      return AppTheme.warningLight;
    }
    return isServiceActive ? AppTheme.successLight : AppTheme.disabledLight;
  }
}
