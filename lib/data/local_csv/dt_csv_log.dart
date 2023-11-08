
class DtCsvLog {

  String color;
  String id;
  String timestamp;
  bool isFinished;
  String? desc;

  DtCsvLog({
    required this.color,
    required this.id,
    required this.timestamp,
    required this.isFinished,
    this.desc,
  });

}