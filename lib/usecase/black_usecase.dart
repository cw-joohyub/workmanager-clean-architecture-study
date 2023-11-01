import 'package:injectable/injectable.dart';

abstract class BlackUsecase {}

@Injectable(as: BlackUsecase)
class BlackUsecaseImpl extends BlackUsecase {}
