import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sierrahilbun/utils/app_size.dart';
import '../../../../constants/app_image_path.dart';
import 'splash_controller.dart'; // আপনার controller এর path দিন

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _circleController;
  late AnimationController _versionController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _circleScaleAnimation;
  late Animation<double> _versionOpacityAnimation;
  late Animation<Offset> _logoSlideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Circle animation controller
    _circleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Version text animation controller
    _versionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Logo animations
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutCubic,
    ));

    // Circle scale animation
    _circleScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _circleController,
      curve: Curves.easeOutBack,
    ));

    // Version text fade in
    _versionOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _versionController,
      curve: Curves.easeIn,
    ));
  }

  void _startAnimations() async {
    // Start circle animation first
    _circleController.forward();

    // Start logo animation after a short delay
    await Future.delayed(const Duration(milliseconds: 500));
    _logoController.forward();

    // Start version text animation
    await Future.delayed(const Duration(milliseconds: 800));
    _versionController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // Controller initialize করুন
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // Background decorative circles with animation
            _buildAnimatedBackgroundCircles(),

            // Main content with animation
            _buildAnimatedMainContent(),

            // Version text with animation
            _buildAnimatedVersionText(),

            // Loading indicator
            _buildLoadingIndicator(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackgroundCircles() {
    return AnimatedBuilder(
      animation: _circleController,
      builder: (context, child) {
        return Stack(
          children: [
            // Left circle with scale animation
            Positioned(
              left: -180,
              top: 208,
              child: Transform.scale(
                scale: _circleScaleAnimation.value,
                child: _buildDecorativeCircle(),
              ),
            ),
            // Right bottom circle with scale animation
            Positioned(
              right: -200,
              bottom: 50,
              child: Transform.scale(
                scale: _circleScaleAnimation.value,
                child: _buildDecorativeCircle(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDecorativeCircle() {
    return Opacity(
      opacity: 0.5,
      child: Container(
        width: AppSize.width(value: 330),
        height: AppSize.height(value: 330),
        decoration: const BoxDecoration(
          color: Color(0xFFD9D9D9),
          shape: BoxShape.circle,
        ),
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedMainContent() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Center(
          child: SlideTransition(
            position: _logoSlideAnimation,
            child: FadeTransition(
              opacity: _logoOpacityAnimation,
              child: ScaleTransition(
                scale: _logoScaleAnimation,
                child: Image.asset(
                  AppImagePath.appLogo,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey,
                    );
                  },
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded) return child;
                    return AnimatedOpacity(
                      opacity: frame == null ? 0 : 1,
                      duration: const Duration(milliseconds: 300),
                      child: child,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedVersionText() {
    return AnimatedBuilder(
      animation: _versionController,
      builder: (context, child) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 56,
          child: FadeTransition(
            opacity: _versionOpacityAnimation,
            child: const Text(
              'Version 0.1',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1C1C1C),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator(SplashController controller) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 120,
      child: Obx(() => AnimatedOpacity(
        opacity: controller.isLoading.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1C1C1C)),
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _circleController.dispose();
    _versionController.dispose();
    super.dispose();
  }
}