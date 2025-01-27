import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'GroceryListScreen.dart';
import 'AddItemScreen.dart';
import 'EditItemScreen.dart';

/// This file defines the state management for the GroceryListScreen, where
/// users can view, add, edit, and delete items in their grocery list.
/// The data is persisted locally using SharedPreferences, allowing the grocery
/// list to be stored and retrieved even after the app is closed.
class GroceryListScreenState extends State<GroceryListScreen> {
  List<Map<String, String>> _items = [];

  /// Loads the initial state.
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  /// This method retrieves the list of items stored in SharedPreferences,
  /// parses and updates the list with the saved data.
  void _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final savedItems = prefs.getStringList('items') ?? [];
      _items = savedItems.map((item) {
        final parts = item.split('|');
        return {
          'name': parts[0],
          'quantity': parts[1],
          'description': parts.length > 2 ? parts[2] : ''
        };
      }).toList();
    });
  }

  /// This method serializes the items in the list and saves them as a string
  /// list in SharedPreferences for persistence.
  void _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final savedItems = _items
        .map((item) =>
            "${item['name']}|${item['quantity']}|${item['description']}")
        .toList();
    prefs.setStringList('items', savedItems);
  }

  /// This method takes the provided name, quantity, and description, adds a new
  /// item to the list, and saves the updated list to SharedPreferences.
  void _addItem(String name, String quantity, String description) {
    setState(() {
      _items.add(
          {'name': name, 'quantity': quantity, 'description': description});
      _saveItems();
    });
  }

  /// This method updates the item at the specified index with the new values
  /// for name, quantity, and description, then saves the updated list to
  /// SharedPreferences.
  void _editItem(int index, String name, String quantity, String description) {
    setState(() {
      _items[index] = {
        'name': name,
        'quantity': quantity,
        'description': description
      };
      _saveItems();
    });
  }

  /// This method removes the item at the specified index from the list and
  /// saves the updated list to SharedPreferences.
  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
      _saveItems();
    });
  }

  /// This method navigates to the AddItemScreen, and upon returning, if a new
  /// item is provided, it is added to the grocery list and saved.
  void _navigateToAddItemScreen(BuildContext context) async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemScreen(),
      ),
    );
    if (newItem != null) {
      _addItem(newItem['name'], newItem['quantity'], newItem['description']);
    }
  }

  /// This method navigates to the EditItemScreen, and upon returning, if the
  /// item is edited, it updates the corresponding item in the list and saves
  /// the changes.
  void _navigateToEditItemScreen(BuildContext context, int index) async {
    final editedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemScreen(item: _items[index]),
      ),
    );
    if (editedItem != null) {
      _editItem(index, editedItem['name'], editedItem['quantity'],
          editedItem['description']);
    }
  }

  /// Builds the UI for the GroceryListScreen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with a gradient background and title.
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
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
          title: Row(
            children: [
              Icon(Icons.shopping_basket, size: 30),
              SizedBox(width: 10),
              Text(
                'Grocery List',
                style: GoogleFonts.pacifico(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
      // Body of the screen.
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'Time to fill your basket!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _navigateToAddItemScreen(context),
                    child: Text('Add Item'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => _deleteItem(index),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          _items[index]['name']![0].toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        _items[index]['name'] ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantity: ${_items[index]['quantity']}'),
                          if (_items[index]['description']?.isNotEmpty ?? false)
                            Text(
                                'Description: ${_items[index]['description']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit,
                            color: Theme.of(context).colorScheme.secondary),
                        onPressed: () =>
                            _navigateToEditItemScreen(context, index),
                      ),
                    ),
                  ),
                );
              },
            ),
      // Floating action button for adding a new item.
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddItemScreen(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
