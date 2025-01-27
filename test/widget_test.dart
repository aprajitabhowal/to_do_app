import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/AddItemScreen.dart';
import 'package:to_do_app/EditItemScreen.dart';
import 'package:to_do_app/GroceryListScreen.dart';
import 'package:to_do_app/MyApp.dart';

/// This method contains comprehensive test cases which test each functionality
/// of the application thoroughly.
void main() {

  // Grouping tests related to MyApp widget.
  group('MyApp Tests', () {
    testWidgets('MyApp widget test', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(GroceryListScreen), findsOneWidget);
    });
  });

  // Grouping tests related to the GroceryListScreen widget.
  group('GroceryListScreen Tests', () {

    // Test to verify the initial state of GroceryListScreen widget.
    testWidgets('GroceryListScreen initial state', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GroceryListScreen()));
      expect(find.text('Time to fill your basket!'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    // Test to verify the Add item button works correctly.
    testWidgets('Add item button test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GroceryListScreen()));
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(AddItemScreen), findsOneWidget);
    });

    // Test to verify that added items display correctly.
    testWidgets('Add and display item test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GroceryListScreen()));
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(0), 'Apple');
      await tester.enterText(find.byType(TextField).at(1), '5');
      await tester.enterText(find.byType(TextField).at(2), 'Red apples');
      await tester.tap(find.text('Add Item'));
      await tester.pumpAndSettle();
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Quantity: 5'), findsOneWidget);
      expect(find.text('Description: Red apples'), findsOneWidget);
    });

    // Test to verify that item edit functionality works correctly.
    testWidgets('Edit item test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GroceryListScreen()));
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(0), 'Apple');
      await tester.enterText(find.byType(TextField).at(1), '5');
      await tester.tap(find.text('Add Item'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      expect(find.byType(EditItemScreen), findsOneWidget);
      await tester.enterText(find.byType(TextField).at(0), 'Green Apple');
      await tester.enterText(find.byType(TextField).at(1), '3');
      await tester.tap(find.text('Save Changes'));
      await tester.pumpAndSettle();
      expect(find.text('Green Apple'), findsOneWidget);
      expect(find.text('Quantity: 3'), findsOneWidget);
    });

    // Test to verify item deletion functionality.
    testWidgets('Delete item test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GroceryListScreen()));
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(0), 'Apple');
      await tester.enterText(find.byType(TextField).at(1), '5');
      await tester.tap(find.text('Add Item'));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(Slidable), Offset(-500.0, 0.0));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.text('Apple'), findsNothing);
    });
  });

  // Grouping tests related to AddItemScreen widget.
  group('AddItemScreen Tests', () {

    // Test to verify form validation in AddItemScreen.
    testWidgets('AddItemScreen validation test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AddItemScreen()));
      await tester.tap(find.text('Add Item'));
      await tester.pump();
      expect(find.text('Quantity is required'), findsOneWidget);
      await tester.enterText(find.byType(TextField).at(1), '-1');
      await tester.pump();
      expect(find.text('Quantity must be positive'), findsOneWidget);
      await tester.enterText(find.byType(TextField).at(1), 'abc');
      await tester.pump();
      expect(find.text('Quantity must be a number'), findsOneWidget);
    });

    // Test to verify successful item addition in AddItemScreen.
    testWidgets('AddItemScreen successful add test',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AddItemScreen()));
      await tester.enterText(find.byType(TextField).at(0), 'Banana');
      await tester.enterText(find.byType(TextField).at(1), '2');
      await tester.enterText(find.byType(TextField).at(2), 'Yellow bananas');
      await tester.tap(find.text('Add Item'));
      await tester.pumpAndSettle();
      expect(find.byType(AddItemScreen), findsNothing);
    });
  });

  // Grouping tests related to EditItemScreen widget.
  group('EditItemScreen Tests', () {

    // Test to verify initial values in EditItemScreen.
    testWidgets('EditItemScreen initial values test',
        (WidgetTester tester) async {
      final item = {
        'name': 'Orange',
        'quantity': '4',
        'description': 'Juicy oranges'
      };
      await tester.pumpWidget(MaterialApp(home: EditItemScreen(item: item)));
      expect(find.text('Orange'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('Juicy oranges'), findsOneWidget);
    });

    // Test to verify validation on EditItemScreen.
    testWidgets('EditItemScreen validation test', (WidgetTester tester) async {
      final item = {
        'name': 'Orange',
        'quantity': '4',
        'description': 'Juicy oranges'
      };
      await tester.pumpWidget(MaterialApp(home: EditItemScreen(item: item)));
      await tester.enterText(find.byType(TextField).at(1), '');
      await tester.tap(find.text('Save Changes'));
      await tester.pump();
      expect(find.text('Quantity is required'), findsOneWidget);
      await tester.enterText(find.byType(TextField).at(1), '-2');
      await tester.pump();
      expect(find.text('Quantity must be positive'), findsOneWidget);
    });

    // Test to verify successful item edit in EditItemScreen.
    testWidgets('EditItemScreen successful edit test',
        (WidgetTester tester) async {
      final item = {
        'name': 'Orange',
        'quantity': '4',
        'description': 'Juicy oranges'
      };
      await tester.pumpWidget(MaterialApp(home: EditItemScreen(item: item)));
      await tester.enterText(find.byType(TextField).at(0), 'Tangerine');
      await tester.enterText(find.byType(TextField).at(1), '6');
      await tester.enterText(find.byType(TextField).at(2), 'Sweet tangerines');
      await tester.tap(find.text('Save Changes'));
      await tester.pumpAndSettle();
      expect(find.byType(EditItemScreen), findsNothing);
    });
  });
}
