library tailwind_components;

/// Flutter components based on Tailwind CSS.
///
/// To use, import `package:tailwind_components/tailwind_components.dart`.
/// 
/// **Setup** - Just add the navigatorKey to your MaterialApp:
/// ```dart
/// MaterialApp(
///   navigatorKey: TailwindComponents.navigatorKey,
///   theme: ThemeData(...),
///   home: MyHomePage(),
/// )
/// ```
/// 
/// That's it! Modals and toasts will work from anywhere in your app.

export 'src/context_manager.dart';
export 'src/wrapper.dart';
export 'src/theme.dart';

export 'src/tw_colors.dart';
export 'src/components/input_field.dart';
export 'src/components/gradient_app_bar.dart';
export 'src/components/gradient_button.dart';
export 'src/components/task_card.dart';
export 'src/validators.dart';
export 'src/components/auto_grid.dart';
export 'src/toast/toast.dart';
export 'src/toast/toast_type_enum.dart';
export 'src/toast/animated_toast_chip.dart';

/// Spacing Row & Column (Removed soon because flutter has this now)
export 'src/components/space_col.dart';
export 'src/components/space_row.dart';

/// Modals
export 'src/modal/modal.dart';
export 'src/modal/modal_handler.dart';
export 'src/modal/tw_modal.dart';
