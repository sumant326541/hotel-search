import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hotel_booking/core/di/injectable.dart';
import 'package:hotel_booking/i18n/strings.g.dart';
import 'package:hotel_booking/main.dart';
import 'package:path_provider/path_provider.dart';

Future<App> buildApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
  EquatableConfig.stringify = true;
  Bloc.observer = SimpleBlocObserver();
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  LocaleSettings.useDeviceLocale();
  configureDependencies();

  return App();
}
