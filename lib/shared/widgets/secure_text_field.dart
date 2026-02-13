import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

/// A text field designed for password input with a visibility toggle.
///
/// Features:
/// - Eye icon to toggle password visibility with haptic feedback
/// - Letter spacing for better readability of obscured text
///
/// Usage:
///   SecureTextField(
///     label: 'Password',
///     controller: passwordController,
///     validator: Validators.password,
///   )
class SecureTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const SecureTextField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.visiblePassword,
  });

  @override
  State<SecureTextField> createState() => _SecureTextFieldState();
}

class _SecureTextFieldState extends State<SecureTextField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    HapticFeedback.lightImpact();
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      style: TextStyle(letterSpacing: 3.w),
      maxLines: 1,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        suffixIcon: GestureDetector(
          onTap: _toggleVisibility,
          child: Icon(
            _obscureText
                ? FluentIcons.eye_24_regular
                : FluentIcons.eye_24_regular,
            color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.6),
            size: 22.sp,
          ),
        ),
      ),
    );
  }
}
