import 'package:flutter/material.dart';
import 'package:anchor/app.dart';
import 'package:anchor/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all dependencies
  di.init();

  runApp(const MyApp());
}
