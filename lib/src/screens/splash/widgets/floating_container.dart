import 'package:coding_diary/src/constants/app_colors.dart';
import 'package:coding_diary/src/constants/asset_constant.dart';
import 'package:flutter/material.dart';

class FloatingContainer extends StatefulWidget {
  const FloatingContainer({super.key});

  @override
  State<FloatingContainer> createState() => _FloatingContainerState();
}

class _FloatingContainerState extends State<FloatingContainer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(0, -0.15))
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
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
    return SlideTransition(
      position: _animation,
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              blurRadius: 15.0,
              color: AppColors.inkMuted,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(Size(50, 50)),
          child: Image.asset(AssetConstant.notebookIcon, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
