import 'package:apiintegration/Services/AvengerServices/MockAvengerService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'App.dart';
import 'BO/AvengerBO/AvengerBO.mapper.g.dart';
import 'Services/AvengerServices/AvengerService.dart';
import 'Services/AvengerServices/IAvengerService.dart';
import 'main.reflectable.dart';

/* Create a main method */
void main() {
  
  /* Call the method named initializeReflectable() */
  initializeReflectable();
  
  /* Call the method named initializeJsonMapper() */
  initializeJsonMapper();

  /* Registering the classAvengerService usng the Getit instance */
  GetIt.instance.registerSingleton<IAvengerService>(AvengerService());

  /* Invoke a method named runApp() and assign constructor as the parameter */
  runApp(const App());
}
