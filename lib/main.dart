import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meditation/di/providers.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/view/home/home_screen.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';
import 'view/intro/intro_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MainViewModel>();

    return MaterialApp(
      title: "Meditation",
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData.dark(),
      home: FutureBuilder(
        future: viewModel.isSkipIntroScreen(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return HomeScreen();
          } else {
            return IntroScreen();
          }
        },
      ),
    );
  }
}
