import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_rental/config/colors.dart';

final floatingIconProvider = StateProvider<IconData>((ref) => Icons.car_rental);

class FloatingIconAnimation extends ConsumerStatefulWidget {
  final IconData? icon;
  final double size;
  final Duration duration;
  final double floatDistance;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? backgroundSize;
  final bool showBackground;

  const FloatingIconAnimation({
    super.key,
    this.icon,
    this.size = 80.0,
    this.duration = const Duration(seconds: 2),
    this.floatDistance = 20.0,
    this.iconColor,
    this.backgroundColor,
    this.backgroundSize,
    this.showBackground = true,
  });

  @override
  ConsumerState<FloatingIconAnimation> createState() =>
      _FloatingIconAnimationState();
}

class _FloatingIconAnimationState extends ConsumerState<FloatingIconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _floatAnimation = Tween<double>(
      begin: -widget.floatDistance / 2,
      end: widget.floatDistance / 2,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final currentIcon = widget.icon ?? ref.watch(floatingIconProvider);

    final iconColor =
        widget.iconColor ?? (isDark ? darkPrimaryColor : lightPrimaryColor);
    final bgColor =
        widget.backgroundColor ?? (isDark ? darkDivColor : lightDivColor);

    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: Container(
            width: widget.backgroundSize ?? (widget.size + 30),
            height: widget.backgroundSize ?? (widget.size + 30),
            decoration:
                widget.showBackground
                    ? BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: (isDark ? Colors.black : Colors.grey)
                              .withValues(alpha: .2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    )
                    : null,
            child: Center(
              child: Icon(currentIcon, size: widget.size, color: iconColor),
            ),
          ),
        );
      },
    );
  }
}

class FloatingIconHelper {
  static void changeIcon(WidgetRef ref, IconData newIcon) {
    ref.read(floatingIconProvider.notifier).state = newIcon;
  }

  static const Map<String, IconData> pageIcons = {
    'home': Icons.home_rounded,
    'car': Icons.directions_car_rounded,
    'search': Icons.search_rounded,
    'profile': Icons.person_rounded,
    'settings': Icons.settings_rounded,
    'favorites': Icons.favorite_rounded,
    'booking': Icons.book_online_rounded,
    'payment': Icons.payment_rounded,
    'location': Icons.location_on_rounded,
    'notification': Icons.notifications_rounded,
  };

  static void setIconForPage(WidgetRef ref, String pageName) {
    final icon = pageIcons[pageName] ?? Icons.help_rounded;
    changeIcon(ref, icon);
  }
}

class FloatingIconExamples extends ConsumerWidget {
  const FloatingIconExamples({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? darkBgColor : lightBgColor,
      appBar: AppBar(
        title: Text(
          'Floating Icon Animation',
          style: TextStyle(
            fontFamily: "Poppins",
            color: isDark ? darkFontColor : lightFontColor,
          ),
        ),
        backgroundColor: isDark ? darkBgColor : lightBgColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Expanded(
            flex: 2,
            child: Center(
              child: FloatingIconAnimation(
                size: 100,
                duration: Duration(milliseconds: 1500),
                floatDistance: 25,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Change Icon:',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark ? darkFontColor : lightFontColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        FloatingIconHelper.pageIcons.entries.map((entry) {
                          return GestureDetector(
                            onTap:
                                () => FloatingIconHelper.changeIcon(
                                  ref,
                                  entry.value,
                                ),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isDark ? darkDivColor : lightDivColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: (isDark
                                          ? darkLableColor
                                          : lightLableColor)
                                      .withValues(alpha: .3),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    entry.value,
                                    color:
                                        isDark
                                            ? darkPrimaryColor
                                            : lightPrimaryColor,
                                    size: 24,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    entry.key,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 10,
                                      color:
                                          isDark
                                              ? darkFontColor
                                              : lightFontColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
