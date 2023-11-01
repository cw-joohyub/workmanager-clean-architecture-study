import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void getItInit({
  EnvironmentFilter? environmentFilter,
}) {
  getIt.$initGetIt(
    environmentFilter: environmentFilter,
  );

}

void resetGetIt<T extends Object>({
  Object? instance,
  String? instanceName,
  void Function(T)? disposingFunction,
}) {
  getIt.resetLazySingleton<T>(
    instance: instance,
    instanceName: instanceName,
    disposingFunction: disposingFunction,
  );
}
