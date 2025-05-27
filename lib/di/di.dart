import 'package:get_it/get_it.dart';
import 'package:water_tracker/features/main/data/repositories/abstract_main_repository.dart';
import 'package:water_tracker/features/main/data/repositories/main_repositroy_impl.dart';
import 'package:water_tracker/services/preferences_service.dart';

final di = GetIt.instance;

void setupDI() {
  di.registerLazySingleton<AbstractMainRepository>(() => MainRepositroyImpl());
  di.registerLazySingleton<PreferencesService>(() => PreferencesService());
}
