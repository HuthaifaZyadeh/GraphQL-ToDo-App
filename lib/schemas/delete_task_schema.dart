class DeleteTaskSchema {
  static String deleteTaskJson = """
  mutation(\$id: Int!){
  deleteTodo(todoId: \$id){
    id
    task
    status
  }
}
""";
}
