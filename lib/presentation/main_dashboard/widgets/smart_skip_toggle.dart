import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SmartSkipToggle extends StatefulWidget {
  final bool isActive;
  final bool isProcessing;
  final VoidCallback onToggle;

  const SmartSkipToggle({
    Key? key,
    required this.isActive,
    required this.isProcessing,
    required this.onToggle,
  }) : super(key: key);

  @override
  State<SmartSkipToggle> createState() => _SmartSkipToggleState();
}

class _SmartSkipToggleState extends State<SmartSkipToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.isProcessing) return;

    HapticFeedback.mediumImpact();
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 35.w,
              height: 35.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: _getGradient(),
                boxShadow: [
                  BoxShadow(
                    color: _getShadowColor(),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: widget.isProcessing
                    ? SizedBox(
                        width: 8.w,
                        height: 8.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.lightTheme.colorScheme.surface,
                          ),
                        ),
                      )
                    : CustomIconWidget(
                        iconName: widget.isActive ? 'pause' : 'play_arrow',
                        color: AppTheme.lightTheme.colorScheme.surface,
                        size: 12.w,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  LinearGradient _getGradient() {
    if (widget.isProcessing) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.warningLight,
          AppTheme.warningLight.withValues(alpha: 0.8),
        ],
      );
    }

    if (widget.isActive) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.primaryLight,
          AppTheme.primaryVariantLight,
        ],
      );
    }

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppTheme.disabledLight,
        AppTheme.disabledLight.withValues(alpha: 0.8),
      ],
    );
  }

  Color _getShadowColor() {
    if (widget.isProcessing) {
      return AppTheme.warningLight.withValues(alpha: 0.3);
    }

    if (widget.isActive) {
      return AppTheme.primaryLight.withValues(alpha: 0.3);
    }

    return AppTheme.disabledLight.withValues(alpha: 0.2);
  }
}
