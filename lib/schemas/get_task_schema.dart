class GetTaskSchema {
  static String getTaskJson = """
  query{
  getTodos(search:"",status:""){
    id
    task
    timeAdded
  }
}
""";
}
