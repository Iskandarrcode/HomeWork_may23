import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List View')),
      body: ListView.builder(
        itemCount: 1000,
        itemBuilder: (context, index) {
          return ItemWidget(index: index);
        },
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final int index;

  const ItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Builder(
        builder: (context) {
          return Text('Item $index');
        },
      ),
    );
  }
}
