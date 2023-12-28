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
| `Input Field` Widget    |   ✔️   |
| `Validators` Library    |   ✔️   |
| `TaskCard` Widget       |   ✔️   |
| `RoundedButton` Widget  |   ✔️   |
| `GradientButton` Widget |   ✔️   |
| `SpaceCol` Widget       |   ✔️   |
| `TWWrapper` Widget      |   ✔️   |
| `Modal` Function        |   ✔️   |
| `SpaceRow` Widget       |   ✔️   |

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

**SpaceCol**

```dart
SpaceCol(
    spaceBetween: 10,
    children: [],
),
```

**SpaceRow**

```dart
SpaceRow(
    spaceBetween: 10,
    children: [],
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





