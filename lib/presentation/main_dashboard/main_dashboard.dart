import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/permission_guide_bottom_sheet.dart';
import './widgets/service_status_indicator.dart';
import './widgets/settings_button_widget.dart';
import './widgets/smart_skip_toggle.dart';
import './widgets/status_text_widget.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard>
    with WidgetsBindingObserver {
  bool _isServiceActive = false;
  bool _isProcessing = false;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeService();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkServiceStatus();
    }
  }

  Future<void> _initializeService() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final savedState = _prefs?.getBool('smart_skip_active') ?? false;

      if (mounted) {
        setState(() {
          _isServiceActive = savedState;
        });
      }

      // Check actual service status
      await _checkServiceStatus();
    } catch (e) {
      _showErrorMessage('Error al inicializar el servicio');
    }
  }

  Future<void> _checkServiceStatus() async {
    try {
      // Simulate checking accessibility service status
      // In real implementation, this would check if accessibility service is running
      final hasPermission = await _hasAccessibilityPermission();

      if (mounted) {
        setState(() {
          if (!hasPermission && _isServiceActive) {
            _isServiceActive = false;
            _saveServiceState();
          }
        });
      }
    } catch (e) {
      // Silent fail for status check
    }
  }

  Future<bool> _hasAccessibilityPermission() async {
    // Simulate accessibility permission check
    // In real implementation, this would use platform channels to check
    // Android accessibility service status
    return false; // Default to false for demo
  }

  Future<void> _toggleService() async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      if (!_isServiceActive) {
        // Activating service
        final hasPermission = await _requestAccessibilityPermission();

        if (hasPermission) {
          setState(() {
            _isServiceActive = true;
            _isProcessing = false;
          });
          await _saveServiceState();
          _showSuccessMessage('Servicio Smart Skip activado');
        } else {
          setState(() {
            _isProcessing = false;
          });
          _showPermissionGuide();
        }
      } else {
        // Deactivating service
        setState(() {
          _isServiceActive = false;
          _isProcessing = false;
        });
        await _saveServiceState();
        _showInfoMessage('Servicio Smart Skip desactivado');
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      _showErrorMessage('Error al cambiar el estado del servicio');
    }
  }

  Future<bool> _requestAccessibilityPermission() async {
    try {
      // Simulate permission request delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // In real implementation, this would:
      // 1. Check if accessibility service is enabled
      // 2. If not, open accessibility settings
      // 3. Return based on user action

      return false; // Default to false to show permission guide
    } catch (e) {
      return false;
    }
  }

  Future<void> _saveServiceState() async {
    try {
      await _prefs?.setBool('smart_skip_active', _isServiceActive);
    } catch (e) {
      // Silent fail for state saving
    }
  }

  void _showPermissionGuide() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PermissionGuideBottomSheet(
        onOpenSettings: () {
          Navigator.pop(context);
          _openAccessibilitySettings();
        },
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  Future<void> _openAccessibilitySettings() async {
    try {
      // In real implementation, this would use platform channels to open
      // Android accessibility settings
      await openAppSettings();
      _showInfoMessage('Configuración de accesibilidad abierta');
    } catch (e) {
      _showErrorMessage('No se pudo abrir la configuración');
    }
  }

  void _openSettings() {
    Navigator.pushNamed(context, '/settings-screen');
  }

  void _showSuccessMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.successLight,
      textColor: Colors.white,
    );
  }

  void _showInfoMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.primaryLight,
      textColor: Colors.white,
    );
  }

  void _showErrorMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.errorLight,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            children: [
              // Top bar with settings
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceStatusIndicator(
                    isServiceActive: _isServiceActive,
                    isProcessing: _isProcessing,
                  ),
                  SettingsButtonWidget(
                    onPressed: _openSettings,
                  ),
                ],
              ),

              // Main content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App title
                    Text(
                      'Smart Skip',
                      style:
                          AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),

                    // Subtitle
                    Text(
                      'Omite anuncios automáticamente',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textMediumEmphasisLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),

                    // Main toggle button
                    SmartSkipToggle(
                      isActive: _isServiceActive,
                      isProcessing: _isProcessing,
                      onToggle: _toggleService,
                    ),
                    SizedBox(height: 6.h),

                    // Status text
                    StatusTextWidget(
                      isServiceActive: _isServiceActive,
                      isProcessing: _isProcessing,
                    ),
                    SizedBox(height: 4.h),

                    // Description
                    Container(
                      padding: EdgeInsets.all(4.w),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(3.w),
                        border: Border.all(
                          color: AppTheme.dividerLight,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          CustomIconWidget(
                            iconName: 'info_outline',
                            color: AppTheme.primaryLight,
                            size: 6.w,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            _isServiceActive
                                ? 'Smart Skip está monitoreando YouTube y omitirá automáticamente los anuncios cuando aparezcan.'
                                : 'Activa Smart Skip para comenzar a omitir anuncios automáticamente en YouTube.',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textMediumEmphasisLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom info
              Padding(
                padding: EdgeInsets.only(bottom: 3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'security',
                      color: AppTheme.successLight,
                      size: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Procesamiento local • Sin recopilación de datos',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textMediumEmphasisLight,
                      ),
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
