import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TroubleshootingSection extends StatefulWidget {
  const TroubleshootingSection({Key? key}) : super(key: key);

  @override
  State<TroubleshootingSection> createState() => _TroubleshootingSectionState();
}

class _TroubleshootingSectionState extends State<TroubleshootingSection> {
  bool _isExpanded = false;

  final List<Map<String, String>> _troubleshootingItems = [
    {
      "problem": "No encuentro Smart Skip en Accesibilidad",
      "solution":
          "Asegúrate de que la aplicación esté instalada correctamente. Reinicia la aplicación e intenta nuevamente.",
    },
    {
      "problem": "La configuración se cierra inesperadamente",
      "solution":
          "Algunos dispositivos requieren reiniciar después de instalar la aplicación. Reinicia tu dispositivo e intenta nuevamente.",
    },
    {
      "problem": "El servicio no aparece habilitado",
      "solution":
          "Ve a Configuración > Aplicaciones > Smart Skip > Permisos y verifica que todos los permisos estén habilitados.",
    },
    {
      "problem": "Ruta diferente en mi dispositivo",
      "solution":
          "En algunos dispositivos: Configuración > Funciones especiales > Accesibilidad, o Configuración > Accesibilidad > Servicios instalados.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'help_outline',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 6.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      "Solución de Problemas",
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  CustomIconWidget(
                    iconName: _isExpanded ? 'expand_less' : 'expand_more',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 6.w,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
              child: Column(
                children: _troubleshootingItems.map((item) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface
                          .withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.lightTheme.dividerColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomIconWidget(
                              iconName: 'error_outline',
                              color: AppTheme.warningLight,
                              size: 5.w,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                item["problem"]!,
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Padding(
                          padding: EdgeInsets.only(left: 7.w),
                          child: Text(
                            item["solution"]!,
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
