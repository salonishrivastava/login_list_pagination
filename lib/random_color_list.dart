import 'dart:math';
import 'package:flutter/material.dart';




class AnimatedListExample extends StatefulWidget {
  const AnimatedListExample({super.key});

  @override
  State<AnimatedListExample> createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Color> _items = [];

  // Random color generator
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  void _addItem() {
    final newColor = getRandomColor();
    final insertIndex = _items.length; // 👈 add at bottom
    _items.insert(insertIndex, newColor);

    _listKey.currentState!.insertItem(
      insertIndex,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _removeItem(int index) {
    final removedColor = _items.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: Container(
          height: 80,
          color: removedColor,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
      ),
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AnimatedList (Items from Bottom)")),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: GestureDetector(
              onTap: () => _removeItem(index),
              child: Container(
                height: 80,
                color: _items[index],
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Center(
                  child: Text(
                    "Item ${index + 1}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
