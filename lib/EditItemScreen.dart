import 'package:flutter/material.dart';
import 'EditItemScreenState.dart';

/// The `EditItemScreen` is a stateful widget that allows users to modify the
/// details of an item passed to it.
class EditItemScreen extends StatefulWidget {
  /// The item to be edited, represented as a map.
  final Map<String, String> item;

  EditItemScreen({required this.item});

  /// This method connects the `EditItemScreen` widget to its associated state
  /// class, `EditItemScreenState`.
  @override
  EditItemScreenState createState() => EditItemScreenState();
}
