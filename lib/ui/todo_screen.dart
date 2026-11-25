// lib/ui/todo_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/todo_provider.dart';


class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    await context.read<TodoProvider>().load();
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoProvider>().items;

    return Scaffold(
      appBar: AppBar(title: const Text('🗒️ Azure Todo Demo')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadTodos,
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (_, i) {
                  final todo = todos[i];
                  return Dismissible(
                    key: ValueKey(todo.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => context.read<TodoProvider>().delete(todo),
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (_) => context.read<TodoProvider>().toggle(todo),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        tooltip: 'Add new todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New Todo'),
        content: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = _controller.text.trim();
              if (title.isNotEmpty) {
                await context.read<TodoProvider>().add(title);
                _controller.clear();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}