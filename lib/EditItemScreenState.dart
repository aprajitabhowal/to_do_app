import 'package:flutter/material.dart';
import 'EditItemScreen.dart';

/// This class is responsible for handling user inputs, validation, and
/// returning the edited item.
class EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _descriptionController;
  String? _quantityError;

  /// It initializes the text controllers with the existing values of the item
  /// being edited.
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item['name']);
    _quantityController = TextEditingController(text: widget.item['quantity']);
    _descriptionController =
        TextEditingController(text: widget.item['description']);
  }

  /// This method checks whether the input is empty, a valid integer, and
  /// greater than zero. If invalid, it sets an error message and returns false.
  /// Otherwise, it returns true.
  bool _validateQuantity(String value) {
    if (value.isEmpty) {
      setState(() => _quantityError = 'Quantity is required');
      return false;
    }
    try {
      int quantity = int.parse(value);
      if (quantity <= 0) {
        setState(() => _quantityError = 'Quantity must be positive');
        return false;
      }
    } catch (e) {
      setState(() => _quantityError = 'Quantity must be a number');
      return false;
    }
    setState(() => _quantityError = null);
    return true;
  }

  /// The build method creates the UI for the EditItemScreen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar provides a title for the screen.
      appBar: AppBar(
        title: Text('Edit Item'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Color(0xFF45A049)
              ],
            ),
          ),
        ),
      ),
      // Ensures padding for better spacing.
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Edit Item Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Edit Quantity',
                errorText: _quantityError,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _validateQuantity(value),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Edit Description (Optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_validateQuantity(_quantityController.text)) {
                  final editedItem = {
                    'name': _nameController.text,
                    'quantity': _quantityController.text,
                    'description': _descriptionController.text,
                  };
                  Navigator.pop(context, editedItem);
                }
              },
              child: Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
