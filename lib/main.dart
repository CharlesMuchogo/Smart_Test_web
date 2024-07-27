import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_app/presentation/authentication/LoginPage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black)
        ),
        scaffoldBackgroundColor: const Color(0XFFE9ECF6) ,
        appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: Color(0XFFE9ECF6)),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFFE9ECF6)),
        useMaterial3: false,
      ),
      home: LoginPage(),
    );
  }
}

