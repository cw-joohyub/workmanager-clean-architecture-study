import 'package:hive/hive.dart';

part 'number_data.g.dart';

@HiveType(typeId: 0)
class NumberData{
  NumberData({
    required this.value,
  });

  @HiveField(0)
  final int value;
}
