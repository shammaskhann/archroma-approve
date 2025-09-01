import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arch_approve/core/constants/app_theme.dart';

class AppTextField extends StatefulWidget {
  final String label; // Label above the field
  final String hintText; // Placeholder inside field
  final IconData prefixIcon; // Prefix icon
  final TextEditingController controller;
  final bool isPassword; // Password toggle
  final RxString? errorText; // Reactive error message (from GetX)

  const AppTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.isPassword = false,
    this.errorText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label Above Field
        Text(widget.label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 6),

        /// TextField
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscure : false,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: kBodyTextStyle.copyWith(color: Colors.grey),

            prefixIcon: Icon(widget.prefixIcon, color: kPrimaryColor),

            // Password Toggle
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: kPrimaryColor,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,

            filled: true,
            fillColor: kLightGreyColor.withOpacity(0.2),

            // Border styles
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: kPrimaryColor, width: 2),
            ),
          ),
        ),

        /// Error Text (Reactive with GetX)
        if (widget.errorText != null)
          Obx(
            () => widget.errorText!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 4),
                    child: Text(
                      widget.errorText!.value,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
      ],
    );
  }
}
