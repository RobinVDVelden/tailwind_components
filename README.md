<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Flutter components based on Tailwind CSS. 

## Features

| Features                | Status |
|-------------------------| :----: |
| `TWColors` Library      |   ✔️   |
| `Validators` Library    |   ✔️   |
| `Input Field` Widget    |   ✔️   |
| `TaskCard` Widget       |   ✔️   |
| `GradientButton` Widget |   ✔️   |
| `AutoGrid` Widget       |   ✔️   |
| `Modal` Functions       |   ✔️   |
| `Toast` Functions       |   ✔️   |

## Usage

Here are some examples how to use some of the components

**Colors**

```dart
TWColors.red_600;
TWColors.indigo_600;
TWColors.emerald_400;
```

**InputField**

```dart
Form(
    key: _formKey,
    child: InputField(
        controller: _controller,
        color: TWColors.indigo_600,
        textCapitalization: TextCapitalization.none,
        keyboardType: TextInputType.emailAddress,
        validators: [Validators.isNotEmpty, Validators.isValidEmail],
        autovalidateMode: AutovalidateMode.always,
        label: 'Email *',
        placeholder: 'Enter your email',
        errorMessage: 'Custom error message',
        enableErrorIcon: true,
    ),
),
```

**AutoGrid**
Automatically creates a grid with a specific amount of columns. All columns extent their height to the largest of the row.

```dart
AutoGrid(
    amountCols: 4,
    gap: 10,
    children: [],
),
```

**Show Toasts**

```dart
Toast.show('Success! ', type: ToastType.success);
Toast.show('Info!', type: ToastType.info);
Toast.show('Warning!', type: ToastType.warning);
Toast.show('Error! ', type: ToastType.error);
```

**Manage Modals**

You can create a Modal widget class that extends **ModalHandler**. This will grand you a variety of functions to manage the modal.

```dart
// Show the modal from anywhere within your flutter application
bool? result = await ExampleModal().show<bool>();


// Create the modal class
class ExampleModal extends ModalHandler {
  const ExampleModal({super.key});

  @override
  Widget build(BuildContext context) {
    return TWModal(
      maxWidth: 350,

      title: const Text('Example Modal'),
      actions: [
        IconButton(
          onPressed: close,
          icon: Icon(Icons.close, size: 16),
        ),
      ],

      body: Text('Close() function is available with a result parameter within ModalHandler.'),

      footer: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => close(),
          ),

          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () => close(result: true),
          ),
        ],
      ),
    );
  }
}
```







