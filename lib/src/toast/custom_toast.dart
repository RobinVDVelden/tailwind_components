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
  
  // Text width measurement
  double? _textWidth;
  double? _textHeight;

  @override
  void initState() {
    super.initState();
    
    // Main controller for the overall sequence - slower
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
      curve: const Interval(0.0, 0.25, curve: Curves.easeOutCubic),
    ));

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
    ));

    // Width expansion animation - slower and smoother
    _widthAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.25, 0.5, curve: Curves.easeOutCubic),
    ));

    _startAnimation();
  }

  void _measureTextWidth() {
    // First measure text without width constraint to get natural width
    final textSpan = TextSpan(
      text: widget.message,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      ),
    );
    
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: null,
    );
    
    // Get natural width (without constraints)
    textPainter.layout();
    final naturalWidth = textPainter.width;
    
    // Calculate optimal width: natural width + padding, but max 70% of screen
    final maxWidth = MediaQuery.of(context).size.width * 0.7;
    final optimalWidth = (naturalWidth + 50).clamp(0.0, maxWidth);
    
    // Now measure with the optimal width to get final dimensions
    textPainter.layout(maxWidth: optimalWidth - 50);
    
    _textWidth = optimalWidth-20;
    _textHeight = textPainter.height + 10;
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
    // Measure text width on first build
    if (_textWidth == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _measureTextWidth();
        setState(() {});
      });
    }

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
                          final targetWidth = _textWidth ?? 0.0;
                          final targetHeight = _textHeight ?? 30.0;

                          return AnimatedContainer(
                            duration: Duration.zero,
                            width: _widthAnimation.value * targetWidth,
                            height: targetHeight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6, right: 8, top: 4),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: SizedBox(
                                      width: (targetWidth - 10).clamp(0.0, double.infinity), // Subtract left/right padding (14) + extra 10 from right
                                      child: DefaultTextStyle(
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.none,
                                        ),
                                        child: Text(
                                          widget.message,
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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