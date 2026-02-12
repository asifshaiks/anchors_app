import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anchor/core/errors/failures.dart';
import 'package:anchor/features/auth/bloc/auth_event.dart';
import 'package:anchor/features/auth/bloc/auth_state.dart';
import 'package:anchor/features/auth/repos/auth_repo.dart';
import 'package:anchor/shared/enums/status.dart';

/// AuthBloc handles all auth logic.
///
/// Flow: View fires Event → Bloc calls Repo → emits State → View rebuilds.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(const AuthState()) {
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final user = await authRepo.login(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: Status.success, user: user));
    } on Failure catch (e) {
      emit(state.copyWith(status: Status.error, errorMessage: e.message));
    }
  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final user = await authRepo.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: Status.success, user: user));
    } on Failure catch (e) {
      emit(state.copyWith(status: Status.error, errorMessage: e.message));
    }
  }
}
