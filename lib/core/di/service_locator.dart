import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:optom/core/di/service_locator.config.dart';

final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> initDependencies() async {
  await locator.init();
}
