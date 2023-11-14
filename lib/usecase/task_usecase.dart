import 'package:injectable/injectable.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';

import 'package:workmanager_clean_architecture_sample/presentation/cubit/work_manager_cubit.dart';

import '../data/repository/task_repository.dart';

abstract class TaskUseCase {

  Stream<List<DtTask>> watchLogChanged();

  Future<void> plusOneNumber(EventType color);

  Future<int> getTaskCount(EventType color);
}

@Injectable(as: TaskUseCase)
class TaskUseCaseImpl extends TaskUseCase {
  TaskUseCaseImpl(this._taskRepository);

  final TaskRepository _taskRepository;


  @override
  Future<void> plusOneNumber(EventType color) async {
    await _taskRepository.postPlusOne(color);
  }

  @override
  Stream<List<DtTask>> watchLogChanged() => _taskRepository.watchTaskChange();


  @override
  Future<int> getTaskCount(EventType color) async {
    return await _taskRepository.getWorkCount(color);
  }

}
