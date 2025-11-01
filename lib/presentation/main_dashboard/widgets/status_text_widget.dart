import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class StatusTextWidget extends StatelessWidget {
  final bool isServiceActive;
  final bool isProcessing;

  const StatusTextWidget({
    Key? key,
    required this.isServiceActive,
    required this.isProcessing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        _getStatusText(),
        key: ValueKey(_getStatusText()),
        style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
          color: _getTextColor(),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  String _getStatusText() {
    if (isProcessing) {
      return 'Configurando Permisos...';
    }
    return isServiceActive ? 'Servicio Activado' : 'Servicio Desactivado';
  }

  Color _getTextColor() {
    if (isProcessing) {
      return AppTheme.warningLight;
    }
    return isServiceActive
        ? AppTheme.successLight
        : AppTheme.textMediumEmphasisLight;
  }
}
