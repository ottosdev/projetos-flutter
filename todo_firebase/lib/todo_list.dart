import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_firebase/loading.dart';
import 'package:todo_firebase/model/todo.dart';
import 'package:todo_firebase/services/firebase.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool isCompleted = false;
  TextEditingController todoTitleControoler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: StreamBuilder<List<Todo>>(
              stream: DataBaseService().listTodos(),
              builder: (context, snapshot) {
                ;
                if (!snapshot.hasData) {
                  return Loading();
                }
                List<Todo>? todos = snapshot.data;

                print(todos);

                return Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Write out your activities",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[200]),
                          ),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 2.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          shrinkWrap: true,
                          itemCount: todos!.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(todos[index].title),
                              background: Container(
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                color: Colors.red,
                              ),
                              onDismissed: (direction) async {
                                await DataBaseService().removedTasks(todos[index].uuid);
                              },
                              child: ListTile(
                                onTap: () {
                                  print(todos[index].uuid);
                                  DataBaseService()
                                      .completedTask(todos[index].uuid);
                                },
                                leading: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle),
                                  child: todos[index].isCompleted
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 10,
                                        )
                                      : Container(),
                                ),
                                title: Text(
                                  todos[index].title,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[200]),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                );
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext biulder) {
                  return SimpleDialog(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Row(
                      children: [
                        Text(
                          "Add Todo",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.cancel),
                          color: Colors.pink,
                        ),
                      ],
                    ),
                    children: [
                      Divider(),
                      TextFormField(
                        controller: todoTitleControoler,
                        autofocus: true,
                        style: TextStyle(
                            color: Colors.white, fontSize: 14, height: 0.5),
                        decoration: InputDecoration(
                          hintText: "ex. running",
                          hintStyle: TextStyle(color: Colors.white),
                          // border: InputBorder.none
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            "Add",
                          ),
                          onPressed: () {
                            
                            if (todoTitleControoler.text.isNotEmpty) {
                              DataBaseService().createNewTodo(
                                  todoTitleControoler.text.trim());
                              setState(() {
                                todoTitleControoler.text = "";
                              });
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                      // Container(
                      //   height: 500,
                      //   width: MediaQuery.of(context).size.width,
                      // )
                    ],
                  );
                });
          },
          child: Icon(Icons.add),
        ));
  }
}
