import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tailwind_components/src/tw_colors.dart';
import 'toast_type.dart';

/// Custom toast widget with complex animations.
class CustomToast extends StatefulWidget {
  final String message;
  final ToastType type;
  final VoidCallback onDismiss;

  const CustomToast({
    super.key,
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  State<CustomToast> createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  
  // Main animation: icon flying up and down
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  
  // Width expansion animation
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    
    // Main controller for the overall sequence
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Slide animation: fly up from bottom
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOutCubic),
    ));

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    ));

    // Width expansion animation
    _widthAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.3, 0.6, curve: Curves.easeOutCubic),
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    // Start main animation
    _mainController.forward();
    
    // Wait 3 seconds, then reverse everything
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      _mainController.reverse();
      await Future.delayed(const Duration(milliseconds: 2500));
      if (mounted) {
        widget.onDismiss();
      }
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    super.dispose();
  }

  Color get color {
    switch (widget.type) {
      case ToastType.success:
        return TWColors.green_500;
      case ToastType.warning:
        return TWColors.orange_500;
      case ToastType.error:
        return TWColors.red_500;
      case ToastType.info:
        return TWColors.blue_500;
    }
  }

  HeroIcons _getIcon() {
    switch (widget.type) {
      case ToastType.success:
        return HeroIcons.checkCircle;
      case ToastType.warning:
        return HeroIcons.exclamationTriangle;
      case ToastType.error:
        return HeroIcons.exclamationTriangle;
      case ToastType.info:
        return HeroIcons.informationCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: _widthAnimation,
              builder: (context, child) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon with colored background
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: HeroIcon(
                          _getIcon(),
                          color: color,
                          size: 28,
                        ),
                      ),
                      
                      // Animated width for text container
                      AnimatedBuilder(
                        animation: _widthAnimation,
                        builder: (context, child) {
                          return AnimatedContainer(
                            duration: Duration.zero,
                            width: _widthAnimation.value * 200, // Adjust based on text length
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6, right: 8),
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                                child: Text(
                                  widget.message,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.none,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
} 