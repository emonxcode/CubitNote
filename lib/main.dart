import 'package:cubit_note/modules/home/controllers/home_controller.dart';
import 'package:cubit_note/modules/home/controllers/home_controller.dart';
import 'package:cubit_note/modules/home/controllers/home_controller.dart';
import 'package:cubit_note/modules/home/views/home_screen.dart';
import 'package:cubit_note/modules/note_view_add_edit/controllers/note_view_controller.dart';
import 'package:cubit_note/modules/note_view_add_edit/views/note_view.dart';
import 'package:cubit_note/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var isDarkMode = prefs.getBool('darkMode') ?? false;
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeController>(
              create: (_) => ThemeController(isDarkTheme: isDarkMode)),
          ChangeNotifierProvider<NoteViewController>(
              create: (_) => NoteViewController()),
          ChangeNotifierProvider<NoteController>(
              create: (_) => NoteController()),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeController>(context);
    final noteController = Provider.of<NoteController>(context);
    noteController.getAllNotes();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getThemeData,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/note-view': (context) => NoteViewScreen(),
      },
    );
  }
}
