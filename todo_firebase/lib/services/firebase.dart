import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/model/todo.dart';

class DataBaseService {
  CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todos');

  Future createNewTodo(String title) async {
    await todosCollection.add({"title": title, "isCompleted": false});
  }

  Future completedTask(uid) async {
    await todosCollection.doc(uid).update({"isCompleted": true});
  }

   Future removedTasks(uid) async {
    await todosCollection.doc(uid).delete();
  }

    List<Todo> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Todo(
          isCompleted: e.get("isCompleted"),
          title: e.get("title"),
          uuid: e.id,
        );
      }).toList();
    } else {
      return [];
    }
  }

  Stream<List<Todo>> listTodos() {
    return todosCollection.snapshots().map(todoFromFirestore);
  }
}
