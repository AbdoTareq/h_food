import 'package:flutter/foundation.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'core/injection_container.dart' as di;
import 'export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kPrimaryColor),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    RequestsInspector(
      navigatorKey: null,
      enabled: kDebugMode,
      showInspectorOn: ShowInspectorOn.LongPress,
      child: TranslationProvider(child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(baseWidth, baseHeight),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          locale: TranslationProvider.of(context).flutterLocale,
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.routes,
        );
      },
    );
  }
}
