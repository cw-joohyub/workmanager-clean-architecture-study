import 'package:injectable/injectable.dart';

// import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalSyncDataSource {

}

@Injectable(as: LocalSyncDataSource)
class LocalSyncDataSourceImpl extends LocalSyncDataSource {
  // LocalSyncDataSourceImpl() {
  //   _init();
  // }
  //
  // Future<void> _init() async {
  //   _prefs = await SharedPreferences.getInstance();
  // }
  //
  // late final SharedPreferences _prefs;
}