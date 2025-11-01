import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GeneralSettingsSection extends StatefulWidget {
  final bool notificationsEnabled;
  final String selectedLanguage;
  final double serviceSensitivity;
  final Function(bool) onNotificationToggle;
  final Function(String) onLanguageChange;
  final Function(double) onSensitivityChange;

  const GeneralSettingsSection({
    super.key,
    required this.notificationsEnabled,
    required this.selectedLanguage,
    required this.serviceSensitivity,
    required this.onNotificationToggle,
    required this.onLanguageChange,
    required this.onSensitivityChange,
  });

  @override
  State<GeneralSettingsSection> createState() => _GeneralSettingsSectionState();
}

class _GeneralSettingsSectionState extends State<GeneralSettingsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Text(
            'Configuración General',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildNotificationTile(),
              _buildDivider(),
              _buildLanguageTile(),
              _buildDivider(),
              _buildSensitivityTile(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationTile() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      leading: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: 'notifications',
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 20,
        ),
      ),
      title: Text(
        'Notificaciones',
        style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        'Recibir notificaciones cuando se salten anuncios',
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color:
              AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: Switch(
        value: widget.notificationsEnabled,
        onChanged: (value) {
          widget.onNotificationToggle(value);
          _showFeedback(
              'Notificaciones ${value ? 'activadas' : 'desactivadas'}');
        },
        activeColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  Widget _buildLanguageTile() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      leading: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color:
              AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CustomIconWidget(
          iconName: 'language',
          color: AppTheme.lightTheme.colorScheme.secondary,
          size: 20,
        ),
      ),
      title: Text(
        'Idioma',
        style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        'Idioma de la interfaz: ${widget.selectedLanguage == 'es' ? 'Español' : 'English'}',
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color:
              AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      trailing: CustomIconWidget(
        iconName: 'arrow_forward_ios',
        color: AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.4),
        size: 16,
      ),
      onTap: () => _showLanguageDialog(),
    );
  }

  Widget _buildSensitivityTile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'tune',
                  color: AppTheme.lightTheme.colorScheme.tertiary,
                  size: 20,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sensibilidad del Servicio',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Ajustar velocidad de detección de anuncios',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppTheme.lightTheme.colorScheme.primary,
              thumbColor: AppTheme.lightTheme.colorScheme.primary,
              overlayColor: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.2),
              inactiveTrackColor: AppTheme.lightTheme.colorScheme.outline,
            ),
            child: Slider(
              value: widget.serviceSensitivity,
              min: 0.0,
              max: 1.0,
              divisions: 4,
              label: _getSensitivityLabel(widget.serviceSensitivity),
              onChanged: (value) {
                widget.onSensitivityChange(value);
              },
              onChangeEnd: (value) {
                _showFeedback(
                    'Sensibilidad ajustada a ${_getSensitivityLabel(value)}');
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lenta',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ),
              ),
              Text(
                'Rápida',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
      indent: 16.w,
    );
  }

  String _getSensitivityLabel(double value) {
    if (value <= 0.2) return 'Muy Lenta';
    if (value <= 0.4) return 'Lenta';
    if (value <= 0.6) return 'Normal';
    if (value <= 0.8) return 'Rápida';
    return 'Muy Rápida';
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Seleccionar Idioma',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Español'),
                value: 'es',
                groupValue: widget.selectedLanguage,
                onChanged: (value) {
                  if (value != null) {
                    widget.onLanguageChange(value);
                    Navigator.of(context).pop();
                    _showFeedback('Idioma cambiado a Español');
                  }
                },
              ),
              RadioListTile<String>(
                title: const Text('English'),
                value: 'en',
                groupValue: widget.selectedLanguage,
                onChanged: (value) {
                  if (value != null) {
                    widget.onLanguageChange(value);
                    Navigator.of(context).pop();
                    _showFeedback('Language changed to English');
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
