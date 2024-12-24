//import 'package:flashcards/models/decks.dart';
import 'package:flashcards/widget/button.dart';
import 'package:flutter/material.dart';

class CreatDeck extends StatefulWidget {
  const CreatDeck({super.key, required this.onAddDeck});
  final Function(String, String?) onAddDeck;

  @override
  State<CreatDeck> createState() => _CreatDeckState();
}

class _CreatDeckState extends State<CreatDeck> {
  final TextEditingController _titleController = TextEditingController();
  String? imagePath =
      "assets/image/cardimg1.png"; // Placeholder for image path (optional)

  void _uploadImage() {
    setState(() {
      imagePath = "assets/image/cardimg3.png";
    });
  }

  void _createDeck() {
    final title = _titleController.text.trim();
    if (title.isNotEmpty) {
      widget.onAddDeck(title, imagePath);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deck created successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Create new deck",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              label: const Text("Title"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Button(nameButton: "Upload Image", onTap: _uploadImage),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: OutlinedButton(
                  onPressed: () {
                    // Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Cancel"),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: ElevatedButton(
                  onPressed: _createDeck,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Add"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
