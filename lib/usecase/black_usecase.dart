// import 'package:injectable/injectable.dart';
// import 'package:workmanager_clean_architecture_sample/data/repository/number_repository.dart';
//
// // import '../data/repository/sync_repository.dart';
//
// abstract class BlackUsecase {
//   void addCount(String color);
//
//   // Future<int> getCount();
//
//   void addLog(String taskName, int retryCount);
// }
//
// @Injectable(as: BlackUsecase)
// class BlackUsecaseImpl extends BlackUsecase {
//   BlackUsecaseImpl(this._numberRepository);
//
//   final NumberRepository _numberRepository;
//
//   @override
//   void addCount(String color) {
//     _numberRepository.postPlusOne(color);
//   }
//
//   @override
//   void addLog(String taskName, int retryCount) {
//     DateTime timeStamp = DateTime.now();
//     print('BlackUsecaseImpl/addLog - $taskName, $timeStamp $retryCount');
//     // _numberRepository.addLog(taskName, timeStamp, retryCount);
//   }
//
// // @override
// // Future<int> getCount() {
// // return _numberRepository.getBlackCount();
// // }
// }
