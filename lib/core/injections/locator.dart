import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:messaging/core/injections/locator.config.dart';

GetIt sl = GetIt.instance;

@injectableInit
Future<void> configureDependecies() async => $initGetIt(sl);
