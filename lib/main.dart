import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokdex/common/app_config.dart';
import 'package:provider/provider.dart';

import 'common/utils/color_utils.dart';
import 'presentation/viewmodels/main_viewmodel.dart';
import 'route_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: AppConfig.apiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainViewmodel(),
      child: MaterialApp.router(
        title: 'Pokedex',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: fromHex("#6C79DB")),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        routerConfig: routeConfig,
      ),
    );
  }
}
