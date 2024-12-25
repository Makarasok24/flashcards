import 'dart:io';

import 'package:flashcards/models/decks.dart';
import 'package:flashcards/screen/home_page.dart';
import 'package:flashcards/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateDeck extends StatefulWidget {
  const CreateDeck({super.key, this.deck, required this.mode});
  final Decks? deck;
  final Mode mode;

  @override
  State<CreateDeck> createState() => _CreateDeckState();
}

class _CreateDeckState extends State<CreateDeck> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final _imagePicker = ImagePicker();
  String _enteredName = "";

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newItem = Decks(
        title: _enteredName,
        image: _selectedImage?.path ?? "",
        cards: [],
      );
      Navigator.of(context).pop(newItem);
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    // setState(() {
    //   _enteredName = "";
    //   _selectedImage = null;
    // });
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty || value.trim().length > 40) {
      return 'Must be between 1 and 40 characters.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if (widget.deck != null) {
      _enteredName = widget.deck!.title;
      if (widget.deck!.image!.isNotEmpty) {
        _selectedImage = File(widget.deck!.image!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.mode == Mode.editing;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Rename Deck" : 'Add a New Deck'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _enteredName,
                maxLength: 40,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: validateTitle,
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 10),
              Button(
                nameButton: "Upload Image",
                onTap: _pickImageFromGallery,
              ),
              const SizedBox(height: 12),
              // Show preview of the selected image
              if (_selectedImage != null)
                Column(
                  children: [
                    const Text('Selected Image:'),
                    const SizedBox(height: 8),
                    _selectedImage == null
                        ? const Text('No image selected')
                        : Image.file(
                            _selectedImage!,
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                  ],
                ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _resetForm,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.red),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveItem,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.blue.shade300),
                    ),
                    child: Text(
                      isEditing ? "Update" : 'Add Deck',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
