# UseMe - Grocery List Application

## Introduction

This file outlines the steps and guidelines to use the **Grocery List App** efficiently. The app allows users to manage their grocery items, add new ones, edit existing ones, and remove unwanted items. All data is saved locally via `SharedPreferences` to ensure persistence even after the app is closed.

## Setting up the Environment

Before using the app, ensure you have the following setup:

### 1. Flutter SDK
Make sure the Flutter SDK is installed on your system.

- **Install Flutter**: [Follow the installation guide here](https://flutter.dev/docs/get-started/install).

### 2. IDE Setup
You can use any IDE such as:
- **Visual Studio Code**: Recommended for Flutter development.
- **Android Studio**: Fully integrated Flutter and Dart support.

Install the necessary Flutter and Dart plugins in your IDE.

### 3. Running the App
1. Clone the repository:
    ```bash
    git clone <repository-url>
    ```

2. Navigate to the project folder and get the dependencies:
    ```bash
    flutter pub get
    ```

3. To run the app on your emulator or a real device, use:
    ```bash
    flutter run
    ```

## Features Walkthrough

### 1. **View Grocery List**

Upon launching the app, the user is presented with the **Grocery List Screen**. The app will display all the items you’ve saved previously in the grocery list. The list will persist even after the app is closed and reopened.

### 2. **Add New Item**

To add a new grocery item:
1. Tap the **Add Item** button.
2. Fill out the item details:
    - **Item Name**
    - **Quantity** (must be a positive numerical value)
    - **Description** (optional)
3. Save the item, which will be added to the list and stored in `SharedPreferences`.

### 3. **Edit Existing Item**

To edit an existing item:
1. Tap the **Edit** icon on the item you want to modify.
2. Make the necessary changes to the name, quantity, and description.
3. Save the updated details, which will replace the previous information.

### 4. **Delete Item**

To delete an item:
1. Swipe left on the item you wish to remove.
2. Tap the **Delete** button to remove the item from the list.

### 5. **Persistence**

The app uses `SharedPreferences` to store the grocery list locally. As a result:
- The list will be preserved even after closing the app.
- Items added or modified are automatically saved to `SharedPreferences`.


