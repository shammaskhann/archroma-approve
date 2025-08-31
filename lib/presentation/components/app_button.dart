import 'package:arch_approve/presentation/components/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:arch_approve/core/constants/app_theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (isDisabled || isLoading) ? null : onPressed,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDisabled ? kPrimaryColor.withOpacity(0.5) : null,
          gradient: isDisabled ? null : kLrtl,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: kDarkPrimaryColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) =>
              FadeTransition(opacity: anim, child: child),
          child: isLoading
              ? const DotsLoader(key: ValueKey("loader"))
              : Text(
                  text,
                  key: const ValueKey("text"),
                  style: kHeadingTextStyle.copyWith(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
