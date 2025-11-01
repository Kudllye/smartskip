import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/app_export.dart';
import './widgets/permission_guide_bottom_sheet.dart';
import './widgets/service_status_indicator.dart';
import './widgets/settings_button_widget.dart';
import './widgets/smart_skip_toggle.dart';
import './widgets/status_text_widget.dart';
import 'package:smart_skip/utils/accessibility_bridge.dart';

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
    _prefs = await SharedPreferences.getInstance();
    await _checkServiceStatus();
  }

  Future<void> _checkServiceStatus() async {
    try {
      final enabled = await AccessibilityBridge.isAccessibilityEnabled();
      if (mounted) {
        setState(() => _isServiceActive = enabled);
      }
    } catch (e) {
      _showErrorMessage('Error al verificar el estado del servicio');
    }
  }

  Future<void> _toggleService() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      if (!_isServiceActive) {
        await AccessibilityBridge.openAccessibilitySettings();
        Future.delayed(const Duration(seconds: 2), _checkServiceStatus);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Desactiva el servicio desde los ajustes de accesibilidad.',
            ),
          ),
        );
      }
    } catch (e) {
      _showErrorMessage('No se pudo cambiar el estado del servicio');
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  void _openSettings() {
    Navigator.pushNamed(context, '/settings-screen');
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
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceStatusIndicator(
                    isServiceActive: _isServiceActive,
                    isProcessing: _isProcessing,
                  ),
                  SettingsButtonWidget(onPressed: _openSettings),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    Text(
                      'Omite anuncios automáticamente',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textMediumEmphasisLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    SmartSkipToggle(
                      isActive: _isServiceActive,
                      isProcessing: _isProcessing,
                      onToggle: _toggleService,
                    ),
                    SizedBox(height: 6.h),
                    StatusTextWidget(
                      isServiceActive: _isServiceActive,
                      isProcessing: _isProcessing,
                    ),
                    SizedBox(height: 4.h),
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
