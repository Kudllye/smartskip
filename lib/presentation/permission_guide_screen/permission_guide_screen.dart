import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_button_widget.dart';
import './widgets/permission_step_card.dart';
import './widgets/troubleshooting_section.dart';

class PermissionGuideScreen extends StatefulWidget {
  const PermissionGuideScreen({Key? key}) : super(key: key);

  @override
  State<PermissionGuideScreen> createState() => _PermissionGuideScreenState();
}

class _PermissionGuideScreenState extends State<PermissionGuideScreen> {
  bool _isLoading = false;
  bool _isCheckingPermissions = false;
  bool _permissionsGranted = false;

  final List<Map<String, dynamic>> _permissionSteps = [
    {
      "stepNumber": 1,
      "title": "Abrir Configuración del Dispositivo",
      "description":
          "Toca el icono de 'Configuración' en tu dispositivo. Generalmente se encuentra en la pantalla principal o en el cajón de aplicaciones.",
      "imageUrl":
          "https://images.unsplash.com/photo-1657885428171-922acd24d134",
      "semanticLabel":
          "Captura de pantalla mostrando el icono de configuración en la pantalla principal de Android con fondo azul"
    },
    {
      "stepNumber": 2,
      "title": "Navegar a Accesibilidad",
      "description":
          "Busca y selecciona 'Accesibilidad' en el menú de configuración. Puede estar en la sección 'Sistema' o 'Funciones especiales' dependiendo de tu dispositivo.",
      "imageUrl":
          "https://images.unsplash.com/photo-1711654311023-22ecd3b33a51",
      "semanticLabel":
          "Menú de configuración de Android mostrando la opción de Accesibilidad resaltada en una lista de configuraciones del sistema"
    },
    {
      "stepNumber": 3,
      "title": "Encontrar Smart Skip",
      "description":
          "En la sección de Accesibilidad, busca 'Smart Skip' en la lista de servicios disponibles. Puede estar bajo 'Servicios instalados' o 'Aplicaciones de accesibilidad'.",
      "imageUrl":
          "https://images.unsplash.com/photo-1711654311023-22ecd3b33a51",
      "semanticLabel":
          "Pantalla de configuración de accesibilidad mostrando una lista de servicios disponibles con Smart Skip visible en la lista"
    },
    {
      "stepNumber": 4,
      "title": "Habilitar el Servicio",
      "description":
          "Toca en 'Smart Skip' y activa el interruptor para habilitar el servicio. Confirma cuando el sistema te pida permisos adicionales.",
      "imageUrl":
          "https://images.unsplash.com/photo-1519558260268-cde7e03a0152",
      "semanticLabel":
          "Pantalla de configuración de Smart Skip mostrando un interruptor activado y texto de confirmación de permisos habilitados"
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkInitialPermissionStatus();
  }

  Future<void> _checkInitialPermissionStatus() async {
    setState(() {
      _isCheckingPermissions = true;
    });

    // Simulate permission check
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _isCheckingPermissions = false;
      _permissionsGranted = false; // Mock: permissions not granted initially
    });
  }

  Future<void> _openAccessibilitySettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate opening accessibility settings
      await Future.delayed(const Duration(milliseconds: 800));

      Fluttertoast.showToast(
        msg: "Abriendo configuración de accesibilidad...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.lightTheme.primaryColor,
        textColor: Colors.white,
        fontSize: 14.sp,
      );

      // Provide haptic feedback
      HapticFeedback.lightImpact();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error al abrir configuración. Intenta manualmente.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.errorLight,
        textColor: Colors.white,
        fontSize: 14.sp,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _checkPermissionStatus() async {
    setState(() {
      _isCheckingPermissions = true;
    });

    try {
      // Simulate permission verification
      await Future.delayed(const Duration(milliseconds: 2000));

      // Mock: simulate successful permission grant
      setState(() {
        _permissionsGranted = true;
      });

      // Show success message
      Fluttertoast.showToast(
        msg: "¡Permisos configurados correctamente!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.successLight,
        textColor: Colors.white,
        fontSize: 14.sp,
      );

      // Provide haptic feedback
      HapticFeedback.mediumImpact();

      // Navigate to main dashboard after success
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/main-dashboard');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "No se pudieron verificar los permisos. Intenta nuevamente.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.warningLight,
        textColor: Colors.white,
        fontSize: 14.sp,
      );
    } finally {
      setState(() {
        _isCheckingPermissions = false;
      });
    }
  }

  Future<void> _refreshPermissionStatus() async {
    HapticFeedback.lightImpact();
    await _checkInitialPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 6.w,
          ),
        ),
        title: Text(
          "Configurar Permisos",
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _isCheckingPermissions
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.lightTheme.primaryColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "Verificando permisos...",
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          : _permissionsGranted
              ? _buildSuccessView()
              : _buildGuideView(),
    );
  }

  Widget _buildSuccessView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: AppTheme.successLight,
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'check',
                color: Colors.white,
                size: 12.w,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "¡Configuración Completada!",
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.successLight,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              "Los permisos de accesibilidad han sido configurados correctamente. Smart Skip está listo para funcionar.",
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            ActionButtonWidget(
              text: "Ir al Panel Principal",
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/main-dashboard');
              },
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideView() {
    return RefreshIndicator(
      onRefresh: _refreshPermissionStatus,
      color: AppTheme.lightTheme.primaryColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              margin: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'info',
                        color: AppTheme.lightTheme.primaryColor,
                        size: 6.w,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          "Configuración Requerida",
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.lightTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Para que Smart Skip funcione correctamente, necesita permisos de accesibilidad. Sigue estos pasos para habilitarlos:",
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            // Steps section
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _permissionSteps.length,
              itemBuilder: (context, index) {
                final step = _permissionSteps[index];
                return PermissionStepCard(
                  stepNumber: step["stepNumber"],
                  title: step["title"],
                  description: step["description"],
                  imageUrl: step["imageUrl"],
                  semanticLabel: step["semanticLabel"],
                );
              },
            ),

            SizedBox(height: 2.h),

            // Action buttons
            ActionButtonWidget(
              text: "Abrir Configuración",
              onPressed: _openAccessibilitySettings,
              isPrimary: true,
              isLoading: _isLoading,
            ),

            ActionButtonWidget(
              text: "Ya Configuré",
              onPressed: _checkPermissionStatus,
              isPrimary: false,
              isLoading: _isCheckingPermissions,
            ),

            SizedBox(height: 2.h),

            // Troubleshooting section
            const TroubleshootingSection(),

            SizedBox(height: 4.h),

            // Footer note
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.lightTheme.dividerColor,
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomIconWidget(
                      iconName: 'security',
                      color: AppTheme.lightTheme.primaryColor,
                      size: 5.w,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Privacidad y Seguridad",
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            "Smart Skip solo procesa información localmente en tu dispositivo. No recopilamos ni compartimos datos personales.",
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
