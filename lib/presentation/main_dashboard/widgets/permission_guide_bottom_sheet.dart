import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class PermissionGuideBottomSheet extends StatelessWidget {
  final VoidCallback onOpenSettings;
  final VoidCallback onClose;

  const PermissionGuideBottomSheet({
    Key? key,
    required this.onOpenSettings,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.w),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 12.w,
              height: 1.h,
              decoration: BoxDecoration(
                color: AppTheme.dividerLight,
                borderRadius: BorderRadius.circular(2.w),
              ),
            ),
          ),
          SizedBox(height: 3.h),

          // Title
          Text(
            'Configuración de Permisos',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),

          // Description
          Text(
            'Para que Smart Skip funcione correctamente, necesita acceso a los servicios de accesibilidad de tu dispositivo.',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMediumEmphasisLight,
            ),
          ),
          SizedBox(height: 3.h),

          // Steps
          _buildStep(
            number: '1',
            title: 'Abrir Configuración',
            description:
                'Toca el botón para ir a la configuración de accesibilidad',
          ),
          SizedBox(height: 2.h),

          _buildStep(
            number: '2',
            title: 'Buscar Smart Skip',
            description: 'Encuentra Smart Skip en la lista de servicios',
          ),
          SizedBox(height: 2.h),

          _buildStep(
            number: '3',
            title: 'Activar Servicio',
            description: 'Activa el interruptor para Smart Skip',
          ),
          SizedBox(height: 4.h),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onClose,
                  child: Text('Cancelar'),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: onOpenSettings,
                  child: Text('Abrir Configuración'),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryLight,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: AppTheme.lightTheme.colorScheme.surface,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                description,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textMediumEmphasisLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
