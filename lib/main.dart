import 'package:flutter/material.dart';
import 'screens/my_home_page.dart';
import 'widgits/my_input_screen.dart';
import 'package:provider/provider.dart';
import 'modules/classes.dart';
import 'screens/details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ImageFile(),
      child: MaterialApp(
        title: 'Deneb',
        theme: ThemeData.dark(),
        home: MyHomePage(),
        routes: {
          MyInputScreen.routeName: (ctx) => MyInputScreen(),
          DetailesScreen.routeName: (ctx) => DetailesScreen(),
        },
      ),
    );
  }
}
