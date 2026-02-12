import 'package:get_it/get_it.dart';
import 'package:anchor/core/network/api_client.dart';
import 'package:anchor/features/auth/repos/auth_repo.dart';
import 'package:anchor/features/auth/bloc/auth_bloc.dart';

/// Service locator instance.
/// Access anywhere: sl<AuthRepo>(), sl<AuthBloc>()
final sl = GetIt.instance;

/// Call this once in main.dart before runApp().
/// Register dependencies bottom-up: network → repos → blocs
void init() {
  // ── Core ──
  sl.registerLazySingleton(() => ApiClient());

  // ── Auth ──
  sl.registerLazySingleton(() => AuthRepo(apiClient: sl()));
  sl.registerFactory(() => AuthBloc(authRepo: sl()));

  // ── Add more features below ──
  // sl.registerLazySingleton(() => HomeRepo(apiClient: sl()));
  // sl.registerFactory(() => HomeBloc(homeRepo: sl()));
}
