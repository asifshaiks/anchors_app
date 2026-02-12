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

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == Status.error && state.errorMessage != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }

              if (state.status == Status.success) {
                // context.go('/home');
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Create Account', style: AppTextStyles.heading),
                  const SizedBox(height: 32),
                  AuthForm(
                    isRegister: true,
                    isLoading: state.status == Status.loading,
                    onSubmit: ({name, required email, required password}) {
                      context.read<AuthBloc>().add(
                        RegisterRequested(
                          name: name!,
                          email: email,
                          password: password,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Already have an account? Login'),
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
