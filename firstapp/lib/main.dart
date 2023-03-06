// ignore_for_file: prefer_const_constructors
//made by @Ronit-gurjar on github

import 'package:firstapp/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //intilalize the hive
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final todoList = Todo.todoList();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color.fromARGB(0, 0, 0, 0)));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todosList = Todo.todoList();
  List<Todo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(206, 20, 20, 20),
          title: Center(child: Text("TODO ;-)")),
        ),
        body: Stack(children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 75,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    searchBox(),
                    Expanded(
                        child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: const Text(
                            "ToDo's :-",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (Todo todoo in _foundTodo)
                          TodoItem(
                            todo: todoo,
                            ontodoChange: _handletodoChange,
                            onDeleteItem: _deletetodoItem,
                          ),
                      ],
                    ))
                  ],
                ),
              )),
          Positioned(
            top: 600,
            left: 0,
            right: 0,
            bottom: 20,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 10, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(206, 20, 20, 20),
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.00,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add new Task',
                      border: InputBorder.none,
                    ),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 10, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addtodoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(206, 20, 20, 20),
                        minimumSize: Size(65, 70),
                        elevation: 20),
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
          )
        ]));
  }

//functionality:--
  void _handletodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deletetodoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addtodoItem(String toDo) {
    setState(() {
      todosList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }

  void _runSearch(String keywordentered) {
    List<Todo> results = [];
    if (keywordentered.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(keywordentered.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: const Color.fromARGB(206, 20, 20, 20),
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runSearch(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Color.fromARGB(236, 250, 250, 28),
              size: 30,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 30, minWidth: 40),
            border: InputBorder.none,
            hintText: 'search here!',
            hintStyle: TextStyle(color: Color.fromARGB(236, 250, 250, 28))),
      ),
    );
  }
}
