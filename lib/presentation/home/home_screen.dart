// Home: full-screen map, drawer (Settings/History), bottom bar, online toggle, ride offer card.

import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../core/config/app_constants.dart';
import '../../core/config/map_style.dart';
import '../../core/widgets/lottie_loading_wrapper.dart';
import 'home_controller.dart';
import 'ride_offer_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    final bool isDark = _isDark(context);
    final Color primaryColor = _isDark(context)
        ? AppConstants.SECONDARY
        : AppConstants.PRIMARY;
    final Color inactiveColor = isDark ? AppConstants.GRAY_LIGHT : AppConstants.GRAY_DARK;

    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: isDark ? AppConstants.BLACK : AppConstants.GRAY_LIGHT,
      extendBody: true,
      drawer: _AppDrawer(
        isDark: isDark,
        scaffoldKey: controller.scaffoldKey,
        onSettings: controller.goToSettings,
        onHistory: controller.goToHistory,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _HomeMapContent(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _OuterGlassContainer(isDark: isDark),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.paddingOf(context).bottom + 20,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      _GlassBottomBar(
                        primaryColor: primaryColor,
                        inactiveColor: inactiveColor,
                        isDark: isDark,
                      ),
                      Positioned(
                        left: 0,
                        child: _OnlineToggle(isDark: isDark),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Drawer header: profile image, name, subtitle; close top-right. Uses darkLight styling.
class _DrawerHeaderWidget extends StatelessWidget {
  const _DrawerHeaderWidget({
    required this.textColor,
    required this.onClose,
  });

  final Color textColor;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 12, 24),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppConstants.WHITE.withValues(alpha: 0.2),
                backgroundImage: const AssetImage(
                  'assets/images/mohamed_ezriouil_1.png',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Mohamed Ezriouil',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Driver',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: onClose,
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Iconsax.arrow_right_3_copy
                    : Iconsax.arrow_left_2_copy,
                color: textColor,
                size: 22,
              ),
              style: IconButton.styleFrom(
                minimumSize: const Size(40, 40),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Drawer: darkLight background, header (profile + name), nav list, version footer.
class _AppDrawer extends StatelessWidget {
  const _AppDrawer({
    required this.isDark,
    required this.scaffoldKey,
    required this.onSettings,
    required this.onHistory,
  });

  final bool isDark;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback onSettings;
  final VoidCallback onHistory;

  static const double _paddingH = 20;
  static const double _spaceBetweenItems = 12;

  @override
  Widget build(BuildContext context) {
    // Same colors as Scaffold background (AppConstants)
    final drawerBg = isDark ? AppConstants.BLACK : AppConstants.GRAY_LIGHT;
    final textColor = isDark ? AppConstants.WHITE : AppConstants.GRAY_DARK;
    final selectedBg = isDark ? AppConstants.WHITE.withValues(alpha: 0.08) : AppConstants.GRAY_DARK.withValues(alpha: 0.08);

    return Drawer(
      backgroundColor: drawerBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DrawerHeaderWidget(
            textColor: textColor,
            onClose: () => scaffoldKey.currentState?.closeDrawer(),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: _paddingH - 4),
            child: Column(
              children: [
                _DrawerItem(
                  icon: Iconsax.home_2_copy,
                  title: 'Home',
                  textColor: textColor,
                  selectedBg: selectedBg,
                  isSelected: true,
                  onTap: () => scaffoldKey.currentState?.closeDrawer(),
                ),
                SizedBox(height: _spaceBetweenItems),
                _DrawerItem(
                  icon: Iconsax.setting_2_copy,
                  title: 'Settings',
                  textColor: textColor,
                  selectedBg: selectedBg,
                  isSelected: false,
                  onTap: () {
                    scaffoldKey.currentState?.closeDrawer();
                    onSettings();
                  },
                ),
                SizedBox(height: _spaceBetweenItems),
                _DrawerItem(
                  icon: Iconsax.clock_copy,
                  title: 'History',
                  textColor: textColor,
                  selectedBg: selectedBg,
                  isSelected: false,
                  onTap: () {
                    scaffoldKey.currentState?.closeDrawer();
                    onHistory();
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Text(
              'Version 1.0.0',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: textColor.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.textColor,
    required this.selectedBg,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color textColor;
  final Color selectedBg;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppConstants.TRANSPARENT,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        overlayColor: WidgetStateProperty.all<Color?>(AppConstants.TRANSPARENT),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? selectedBg : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: textColor,
                size: 22,
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textColor,
                      // fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeMapContent extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Obx(() => controller.mapLoading.value
            ? const LottieMapLoading()
            : GoogleMap(
                initialCameraPosition: HomeController.initialCameraPosition,
                onMapCreated: controller.onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                style: mapStyleUber,
              )),
        Obx(() {
          return Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.paddingOf(context).bottom + 100,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              switchInCurve: Curves.linear,
              switchOutCurve: Curves.linear,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.linear,
                  )),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: controller.isOnline.value
                  ? RideOfferCard(
                      key: const ValueKey('ride_offer'),
                      trip: controller.nextOffer,
                    )
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          );
        }),
        Positioned(
          top: MediaQuery.paddingOf(context).top + 12,
          right: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _GlassCircleButton(
                isDark: isDark,
                icon: Iconsax.search_zoom_in_1_copy,
                onTap: controller.zoomIn,
              ),
              const SizedBox(height: 8),
              _GlassCircleButton(
                isDark: isDark,
                icon: Iconsax.search_zoom_out_1_copy,
                onTap: controller.zoomOut,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GlassCircleButton extends StatelessWidget {
  const _GlassCircleButton({
    required this.isDark,
    required this.icon,
    required this.onTap,
  });

  final bool isDark;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (isDark ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT).withValues(alpha: isDark ? 0.5 : 0.1),
              border: Border.all(
                color: isDark
                    ? AppConstants.GRAY_LIGHT.withValues(alpha: 0.15)
                    : AppConstants.GRAY_DARK.withValues(alpha: 0.6),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.BLACK.withValues(alpha: isDark ? 0.15 : 0.04),
                  blurRadius: 24,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 22,
              color: isDark ? AppConstants.WHITE : AppConstants.GRAY_DARK,
            ),
          ),
        ),
      ),
    );
  }
}

class _OuterGlassContainer extends StatelessWidget {
  const _OuterGlassContainer({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            top: 14,
            left: 16,
            right: 16,
            bottom: bottomPadding + 20 + 52,
          ),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(24),
            color: (isDark ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT).withValues(alpha: isDark ? 0.2 : 0.1),
            border: Border.all(
              color: isDark
                  ? (isDark ? AppConstants.GRAY_LIGHT : AppConstants.GRAY_DARK).withValues(alpha: 0.15)
                  : (isDark ? AppConstants.GRAY_LIGHT : AppConstants.GRAY_DARK).withValues(alpha: 0.6),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppConstants.BLACK.withValues(alpha: isDark ? 0.15 : 0.04),
                blurRadius: 24,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          
        ),
      ),
    );
  }
}

class _GlassBottomBar extends GetView<HomeController> {
  const _GlassBottomBar({
    required this.primaryColor,
    required this.inactiveColor,
    required this.isDark,
  });

  final Color primaryColor;
  final Color inactiveColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentIndex = controller.currentIndex.value;
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: (isDark ? AppConstants.GRAY_DARK : AppConstants.GRAY_LIGHT).withValues(alpha: isDark ? 0.5 : 0.1),
          border: Border.all(
            color: isDark
                ? AppConstants.GRAY_LIGHT.withValues(alpha: 0.15)
                : AppConstants.GRAY_DARK.withValues(alpha: 0.6),
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants.BLACK.withValues(alpha: isDark ? 0.15 : 0.04),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _NavIcon(
              icon: Iconsax.home_copy,
              isSelected: currentIndex == 0,
              primaryColor: primaryColor,
              inactiveColor: inactiveColor,
              onTap: () => controller.setIndex(0),
            ),
            const SizedBox(width: 20),
            _NavIcon(
              icon: Iconsax.setting_2_copy,
              isSelected: currentIndex == 1,
              primaryColor: primaryColor,
              inactiveColor: inactiveColor,
              onTap: () => controller.setIndex(1),
            ),
          ],
        ),
      );
    });
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.icon,
    required this.isSelected,
    required this.primaryColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final Color primaryColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppConstants.TRANSPARENT,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 24,
            color: inactiveColor,
          ),
        ),
      ),
    );
  }
}

class _OnlineToggle extends GetView<HomeController> {
  const _OnlineToggle({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isOnline = controller.isOnline.value;
      final statusColor = isOnline
          ? AppConstants.GREEN_DARK
          : AppConstants.RED_DARK;
      final container = GestureDetector(
        onTap: controller.toggleOnline,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppConstants.TRANSPARENT,
            border: Border.all(
              color: statusColor.withValues(alpha: 0.5),
                width: 0.5,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            isOnline ? Iconsax.eye_copy : Iconsax.eye_slash_copy,
            size: 20,
            color: statusColor,
          ),
        ),
      );
      return AvatarGlow(
        animate: true,
        glowColor: statusColor,
        glowRadiusFactor: 0.3,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        child: container,
      );
    });
  }
}
