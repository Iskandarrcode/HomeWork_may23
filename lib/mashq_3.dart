import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Loading'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20),
        itemCount: 50,
        itemBuilder: (context, index) {
          return Image.network(
            "https://i.ebayimg.com/images/g/mrQAAOSww5Rj9PFp/s-l1200.jpg",
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color.fromARGB(227, 21, 34, 109),
                    color: Colors.white,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
