import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final String initialTitle;
  final bool initialIsDone;
  final VoidCallback onDelete; // Require a callback for delete action

  const TodoCard({
    super.key,
    required this.initialTitle,
    required this.initialIsDone,
    required this.onDelete, // Mark it as required
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  late String title;
  late bool isDone;

  @override
  void initState() {
    super.initState();
    title = widget.initialTitle;
    isDone = widget.initialIsDone;
  }

  void toggleDone() {
    setState(() {
      isDone = !isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleDone,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          elevation: 0,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Checkbox(
                value: isDone,
                onChanged: (value) => toggleDone(),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
                decorationThickness: 1.5,
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: widget.onDelete, // Calls the required callback
              ),
            ),
          ),
        ),
      ),
    );
  }
}
