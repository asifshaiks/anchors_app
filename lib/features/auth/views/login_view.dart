import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:anchor/core/di/injection_container.dart';
import 'package:anchor/features/auth/bloc/auth_bloc.dart';
import 'package:anchor/features/auth/bloc/auth_event.dart';
import 'package:anchor/features/auth/bloc/auth_state.dart';
import 'package:anchor/features/auth/widgets/auth_form.dart';
import 'package:anchor/shared/enums/status.dart';
import 'package:anchor/config/theme/text_styles.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              // Show error snackbar
              if (state.status == Status.error && state.errorMessage != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }

              // Navigate on success
              if (state.status == Status.success) {
                // context.go('/home');
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome Back', style: AppTextStyles.heading),
                  const SizedBox(height: 32),
                  AuthForm(
                    isLoading: state.status == Status.loading,
                    onSubmit: ({name, required email, required password}) {
                      context.read<AuthBloc>().add(
                        LoginRequested(email: email, password: password),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.go('/register'),
                    child: const Text("Don't have an account? Register"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
