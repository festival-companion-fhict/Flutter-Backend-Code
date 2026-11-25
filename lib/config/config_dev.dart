// lib/config/config_dev.dart
import 'app_config.dart';

/// Development configuration – points to the local Azure Function emulator
const AppConfig devConfig = AppConfig(baseUrl: 'http://localhost:7071/api');