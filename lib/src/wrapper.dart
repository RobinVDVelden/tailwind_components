import 'package:flutter/material.dart';
import 'context_manager.dart';

/// A wrapper widget that automatically initializes TailwindComponents.
/// 
/// Wrap your MaterialApp with this widget to enable all TailwindComponents features.
/// The theme from your MaterialApp will be automatically used:
/// ```dart
/// TailwindComponents(
///   child: MaterialApp(
///     theme: ThemeData(...),
///     darkTheme: ThemeData.dark(...),
///     home: MyHomePage(),
///   ),
/// )
/// ```
class TailwindComponents extends StatelessWidget {
  final Widget child;

  const TailwindComponents({
    super.key,
    required this.child,
  });

  Widget Function(BuildContext, Widget?)? _createBuilder(MaterialApp app) {
    final originalBuilder = app.builder;
    
    return (context, childWidget) {
      ContextManager.init(context);
      return originalBuilder?.call(context, childWidget) ?? childWidget ?? const SizedBox.shrink();
    };
  }

  MaterialApp _copyMaterialAppWithBuilder(MaterialApp app) {
    final builder = _createBuilder(app);
    
    if (app.routerConfig != null) {
      return MaterialApp.router(
        key: app.key,
        routerConfig: app.routerConfig,
        scaffoldMessengerKey: app.scaffoldMessengerKey,
        builder: builder,
        title: app.title,
        onGenerateTitle: app.onGenerateTitle,
        color: app.color,
        theme: app.theme,
        darkTheme: app.darkTheme,
        highContrastTheme: app.highContrastTheme,
        highContrastDarkTheme: app.highContrastDarkTheme,
        themeMode: app.themeMode,
        locale: app.locale,
        localizationsDelegates: app.localizationsDelegates,
        supportedLocales: app.supportedLocales,
        debugShowMaterialGrid: app.debugShowMaterialGrid,
        showPerformanceOverlay: app.showPerformanceOverlay,
        checkerboardRasterCacheImages: app.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: app.checkerboardOffscreenLayers,
        showSemanticsDebugger: app.showSemanticsDebugger,
        debugShowCheckedModeBanner: app.debugShowCheckedModeBanner,
        shortcuts: app.shortcuts,
        actions: app.actions,
        restorationScopeId: app.restorationScopeId,
        scrollBehavior: app.scrollBehavior,
        useInheritedMediaQuery: app.useInheritedMediaQuery,
      );
    }
    
    return MaterialApp(
      key: app.key,
      navigatorKey: app.navigatorKey ?? ContextManager.navigatorKey,
      scaffoldMessengerKey: app.scaffoldMessengerKey,
      home: app.home,
      routes: app.routes ?? const <String, WidgetBuilder>{},
      initialRoute: app.initialRoute,
      onGenerateRoute: app.onGenerateRoute,
      onGenerateInitialRoutes: app.onGenerateInitialRoutes,
      onUnknownRoute: app.onUnknownRoute,
      navigatorObservers: app.navigatorObservers ?? const [],
      builder: builder,
      title: app.title,
      onGenerateTitle: app.onGenerateTitle,
      color: app.color,
      theme: app.theme,
      darkTheme: app.darkTheme,
      highContrastTheme: app.highContrastTheme,
      highContrastDarkTheme: app.highContrastDarkTheme,
      themeMode: app.themeMode,
      locale: app.locale,
      localizationsDelegates: app.localizationsDelegates,
      supportedLocales: app.supportedLocales,
      debugShowMaterialGrid: app.debugShowMaterialGrid,
      showPerformanceOverlay: app.showPerformanceOverlay,
      checkerboardRasterCacheImages: app.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: app.checkerboardOffscreenLayers,
      showSemanticsDebugger: app.showSemanticsDebugger,
      debugShowCheckedModeBanner: app.debugShowCheckedModeBanner,
      shortcuts: app.shortcuts,
      actions: app.actions,
      restorationScopeId: app.restorationScopeId,
      scrollBehavior: app.scrollBehavior,
      useInheritedMediaQuery: app.useInheritedMediaQuery,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (child is MaterialApp) {
      return _copyMaterialAppWithBuilder(child as MaterialApp);
    }
    return child;
  }
} 