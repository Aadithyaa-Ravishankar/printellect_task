import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'firebase_options.dart';
import 'core/providers/app_state.dart';

// Mobile Screens
import 'ui/screens/login_screen.dart';
import 'ui/screens/main_screen.dart';

// Web Screens
import 'web/screens/web_login_screen.dart';
import 'web/screens/web_cart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'Printellect Interview',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: Consumer<AppState>(
          builder: (context, state, child) {
            if (kIsWeb) {
              return state.email == null
                  ? WebLoginScreen()
                  : const WebCartScreen();
            } else {
              return state.email == null ? LoginScreen() : const MainScreen();
            }
          },
        ),
      ),
    );
  }
}
