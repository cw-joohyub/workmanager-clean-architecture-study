import 'package:injectable/injectable.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';

import 'package:workmanager_clean_architecture_sample/presentation/cubit/work_manager_cubit.dart';

import '../data/repository/task_repository.dart';

abstract class TaskUseCase {

  Stream<List<DtTask>> getTaskListStream();

  Future<List<DtTask>?> getTaskList();

  Future<void> plusOneNumber(EventType color);

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
  Stream<List<DtTask>> getTaskListStream() => _taskRepository.getTaskListStream();

  @override
  Future<List<DtTask>?> getTaskList() {
    return _taskRepository.getTaskList();
  }

}
