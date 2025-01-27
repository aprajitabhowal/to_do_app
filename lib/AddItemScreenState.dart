import 'package:flutter/material.dart';
import 'AddItemScreen.dart';

/// The `AddItemScreenState` class handles the logic and UI for adding a new
/// item to the list. It includes form validation for the item name, quantity
/// and an optional description.
class AddItemScreenState extends State<AddItemScreen> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _quantityError;

  /// This method checks that the quantity is a valid positive integer.
  /// If invalid, an error message is shown. Else, it clears the error state.
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

  /// This method defines the visual structure and layout of the screen.
  @override
  Widget build(BuildContext context) {
    // Builds the UI for the AddItemScreen.
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_cart),
              ),
            ),
            SizedBox(height: 10),
            // Quantity input field with validation.
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                errorText: _quantityError,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _validateQuantity(value),
            ),
            SizedBox(height: 10),
            // Optional description input field.
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description (Optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
            ),
            SizedBox(height: 20),
            // Add Item button.
            ElevatedButton(
              onPressed: () {
                // Only add the item if quantity is valid.
                if (_validateQuantity(_quantityController.text)) {
                  final newItem = {
                    'name': _nameController.text,
                    'quantity': _quantityController.text,
                    'description': _descriptionController.text,
                  };
                  Navigator.pop(context, newItem);
                }
              },
              child: Text('Add Item'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
