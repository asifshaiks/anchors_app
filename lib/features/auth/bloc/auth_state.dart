import 'package:equatable/equatable.dart';
import 'package:anchor/features/auth/models/user_model.dart';
import 'package:anchor/shared/enums/status.dart';

/// Single state class for auth.
/// Status tracks where we are: initial → loading → success/error.
class AuthState extends Equatable {
  final Status status;
  final UserModel? user;
  final String? errorMessage;

  const AuthState({this.status = Status.initial, this.user, this.errorMessage});

  /// Create a copy with some fields changed.
  /// Usage: emit(state.copyWith(status: Status.loading))
  AuthState copyWith({Status? status, UserModel? user, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
