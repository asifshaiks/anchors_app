# Flutter Starter Template

MVVM architecture with BLoC state management.

## Architecture

```
View → fires Event → Bloc → calls Repo → Repo calls API → Bloc emits State → View rebuilds
```

## Folder Structure

```
lib/
├── core/          → Stuff every feature uses (API, DI, routes, errors, utils)
├── shared/        → Reusable widgets, models, enums
├── config/        → Theme, text styles
├── features/      → Each feature is self-contained
│   └── feature_name/
│       ├── models/
│       ├── repos/
│       ├── bloc/
│       ├── views/
│       └── widgets/
├── app.dart       → Root widget
└── main.dart      → Entry point
```

## How to Add a New Feature

1. Create the feature folder:
```bash
mkdir -p lib/features/YOUR_FEATURE/{models,repos,bloc,views,widgets}
```

2. Create files in this order:
   - `models/` → Your data model with `fromJson`/`toJson`
   - `repos/` → API calls using `ApiClient`
   - `bloc/` → Events, State, and Bloc
   - `views/` → Screens
   - `widgets/` → Feature-specific widgets

3. Register in `core/di/injection_container.dart`:
```dart
sl.registerLazySingleton(() => YourRepo(apiClient: sl()));
sl.registerFactory(() => YourBloc(yourRepo: sl()));
```

4. Add route in `core/routes/app_router.dart`:
```dart
GoRoute(
  path: '/your-feature',
  builder: (context, state) => const YourView(),
),
```

## Setup

```bash
flutter pub get
dart run build_runner build    # Generate .g.dart files
```

## Conventions

- **Repos** throw `Failure` on errors — Blocs catch them.
- **Bloc states** use `Status` enum (initial, loading, success, error).
- **BlocProvider** is created in the View, not above it.
- One Bloc per feature. Split only if the feature grows complex.
- Shared widgets go in `shared/widgets/`. Feature-specific widgets stay in the feature.

## Packages

| Package | Purpose |
|---------|---------|
| flutter_bloc | State management |
| equatable | Value equality for events/states |
| dio | HTTP client |
| get_it | Dependency injection |
| go_router | Routing |
| shared_preferences | Local storage |
| json_serializable | JSON parsing code generation |

flutter pub run build_runner build --delete-conflicting-outputs
