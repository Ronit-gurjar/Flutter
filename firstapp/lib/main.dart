import 'package:firstapp/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(206, 20, 20, 20),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: Color.fromARGB(236, 250, 250, 28),
              size: 30,
            ),
            Container(
              height: 50,
              width: 50,
              child: const ClipRRect(
                child: Icon(
                  Icons.mail,
                  size: 30,
                  color: Color.fromARGB(236, 250, 250, 28),
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            searchBox(),
            Expanded(
                child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    "TODO's",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                for (Todo todo in Todo.todoList())
                  TodoItem(
                    todo: todo,
                  ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

Widget searchBox() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    decoration: BoxDecoration(
        color: Color.fromARGB(206, 20, 20, 20),
        borderRadius: BorderRadius.circular(20)),
    child: const TextField(
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
