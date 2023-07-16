import 'package:flutter/material.dart';
import 'package:to_do_list_new/domain/routes/navigation_manager.dart';
import 'package:to_do_list_new/internal/dependencies/locator.dart';
import 'package:to_do_list_new/presentation/features/task_info/create_task_widget.dart';
import 'package:to_do_list_new/presentation/features/task_info/app_bar.dart';
import 'package:to_do_list_new/s.dart';

class CreateTaskScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final id;
  const CreateTaskScreen({Key? key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tasksState = Locator.tasksState;
    bool newTask = tasksState.task.id == '';
    return Scaffold(
      appBar: TaskInfoAppBar(
          saveText: S.of(context).get("save"),
          backOnPressed: () {
            tasksState.disposeTask();
            NavigationManager.instance.pop();
          },
          saveOnPressed: () {
            if (newTask == true) {
              if (tasksState.task.text != '') {
                NavigationManager.instance.navigateToHome();
                tasksState.saveNewTask();
                tasksState.disposeTask();
              } else {
                null;
              }
            } else {
              tasksState.saveTask(id);
              tasksState.disposeTask();
              NavigationManager.instance.navigateToHome();
            }
          }),
      body: CreateTaskWidget(id: id),
    );
  }
}
