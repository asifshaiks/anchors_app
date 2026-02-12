import 'package:flutter/material.dart';

/// Full-screen loading overlay.
///
/// Usage: Wrap your Scaffold body:
///   LoadingOverlay(
///     isLoading: state is AuthLoading,
///     child: YourContent(),
///   )
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
