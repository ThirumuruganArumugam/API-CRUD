// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'Helpers/AppNavigations/NavigationConfig.dart';
import 'Helpers/AppNavigations/NavigationHelpers.dart';

// Create a statefulwidget named App
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      // Set the homescrenconfig as initial page and initialpageData as empty.   
      onGenerateRoute: AppRoute(
        initialPage: Pages.homeScreenConfig,
        initialPageData: "",
      ).onGenerateRoute,
    );
  }
}
