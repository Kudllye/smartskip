import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Simulate initialization tasks
      await Future.wait([
        _checkAccessibilityPermissions(),
        _loadUserPreferences(),
        _verifyYouTubeInstallation(),
        _prepareCachedServiceState(),
      ]);

      // Minimum splash duration
      await Future.delayed(const Duration(milliseconds: 2500));

      if (mounted) {
        _navigateToNextScreen();
      }
    } catch (e) {
      if (mounted) {
        _handleInitializationError();
      }
    }
  }

  Future<bool> _checkAccessibilityPermissions() async {
    // Mock accessibility permission check
    await Future.delayed(const Duration(milliseconds: 500));
    return false; // Simulate first-time user
  }

  Future<void> _loadUserPreferences() async {
    // Mock loading user preferences
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<bool> _verifyYouTubeInstallation() async {
    // Mock YouTube app verification
    await Future.delayed(const Duration(milliseconds: 200));
    return true; // Simulate YouTube is installed
  }

  Future<void> _prepareCachedServiceState() async {
    // Mock service state preparation
    await Future.delayed(const Duration(milliseconds: 400));
  }

  void _navigateToNextScreen() {
    setState(() {
      _isInitializing = false;
    });

    // Navigate based on user state
    Navigator.pushReplacementNamed(context, '/permission-guide-screen');
  }

  void _handleInitializationError() {
    // Show error dialog and retry option
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Error de Inicialización',
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        content: Text(
          'Hubo un problema al inicializar la aplicación. ¿Deseas intentar de nuevo?',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initializeApp();
            },
            child: const Text('Reintentar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              SystemNavigator.pop();
            },
            child: const Text('Salir'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.lightTheme.colorScheme.primary,
              AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.8),
              AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.6),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildLogo(),
                              SizedBox(height: 3.h),
                              _buildAppTitle(),
                              SizedBox(height: 1.h),
                              _buildSubtitle(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isInitializing) _buildLoadingIndicator(),
                    SizedBox(height: 4.h),
                    _buildVersionInfo(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: CustomIconWidget(
          iconName: 'skip_next',
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 12.w,
        ),
      ),
    );
  }

  Widget _buildAppTitle() {
    return Text(
      'Smart Skip',
      style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
        letterSpacing: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Salta anuncios automáticamente',
      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
        color: Colors.white.withValues(alpha: 0.9),
        fontSize: 12.sp,
        fontWeight: FontWeight.w300,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 8.w,
          height: 8.w,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          'Inicializando servicios...',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildVersionInfo() {
    return Text(
      'Versión 1.0.0',
      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
        color: Colors.white.withValues(alpha: 0.6),
        fontSize: 9.sp,
      ),
    );
  }
}
