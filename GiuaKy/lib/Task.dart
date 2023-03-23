class Task {
  String name;
  DateTime deadline;
  bool isLate;
  bool isCompleted; // thêm thuộc tính isCompleted

  Task(this.name, this.deadline, this.isLate, {this.isCompleted = false});

  void complete() {
    isCompleted = !isCompleted;
  }

}
