import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../widgets/TodoCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> todos = [];
  var haptick = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? storedTodos = prefs.getString('todos');
    if (storedTodos != null) {
      setState(() {
        todos = List<Map<String, dynamic>>.from(json.decode(storedTodos));
      });
    } else {
      todos = [
        {"title": "Buy Groceries", "isDone": false},
        {"title": "Fix bugs in Xed-Editor", "isDone": false},
        {"title": "Test Flutter drag feature", "isDone": false},
      ];
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('todos', json.encode(todos));
  }

  void _onReorder(int oldIndex, int newIndex) {
    haptick = true;
    if (newIndex > oldIndex) newIndex -= 1;
    final movedItem = todos.removeAt(oldIndex);
    todos.insert(newIndex, movedItem);
    _saveTodos();
    setState(() {});
  }

  void _addTodo() {
    setState(() {
      todos.add({"title": "New Task", "isDone": false});
    });
    _saveTodos();
  }

  void _deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
    _saveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:
              () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        ),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: _addTodo)],
      ),
      body: ReorderableListView.builder(
        proxyDecorator: (child, index, animation) {
          if (haptick) {
            HapticFeedback.mediumImpact();
            haptick = false;
          }
          return child;
        },
        itemCount: todos.length,
        onReorder: _onReorder,
        itemBuilder: (context, index) {
          return TodoCard(
            key: ValueKey(todos[index]),
            initialTitle: todos[index]['title'],
            initialIsDone: todos[index]['isDone'],
            onDelete: () => _deleteTodo(index),
          );
        },
      ),
    );
  }
}
