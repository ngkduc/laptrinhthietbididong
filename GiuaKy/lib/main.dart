import 'package:flutter/material.dart';
import 'Task.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListPage(),
    );
  }
}

class TaskListPage extends StatefulWidget {
  @override
  TaskListPageState createState() => TaskListPageState();
}

class TaskListPageState extends State<TaskListPage> {
  List<Task> tasks = [
    Task('đi ăn với khách hàng', DateTime(2023,04,07), false),
    Task('đi du lịch',DateTime(2023,04,17),false)

  ];
  void addTask(String name, DateTime deadline) {
    final isLate = DateTime.now().isAfter(deadline);
    final task = Task(name, deadline, isLate);
    setState(() {
      tasks.add(task);
    });
    Navigator.of(context).pop();
  }
  void showAddTaskDialog() {
    final nameController = TextEditingController();
    late DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Task Name',
                ),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: IgnorePointer(
                  child: TextField(
                    controller: TextEditingController(
                      text: selectedDate == null ? '' : selectedDate.toString(),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Deadline',
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final name = nameController.text;
                addTask(name, selectedDate);
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildTaskList() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.name),
          subtitle: Text('Deadline: ${task.deadline}'),
          trailing:
          task.isCompleted ? Icon(Icons.check_box, color: Colors.green) :
          task.isLate ? Text('Late', style: TextStyle(color: Colors.red)) : null,
          onTap: () {
            setState(() {
              task.isCompleted = !task.isCompleted;
            });
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Task Manager'),
  //     ),
  //     body: Column(
  //         children: [
  //         ElevatedButton(
  //         onPressed: () {
  //
  //   },
  //     child: const Text('Thêm'),
  //   ),
  //   ElevatedButton(
  //   onPressed: () {
  //   // Hàm xử lý khi bấm vào nút sửa
  //   },
  //   child: const Text('Sửa'),
  //   ),
  //   ElevatedButton(
  //   onPressed: () {
  //   // Hàm xử lý khi bấm vào nút xóa
  //   },
  //   child: const Text('Xóa'),
  //   ),
  //   ElevatedButton(
  //   onPressed: () {
  //   // Hàm xử lý khi bấm vào nút viewList
  //   },
  //   child: const Text('ViewList'),
  //     // buildTaskList(),
  //   ),
  //   ],
  //   ),
  //   );


