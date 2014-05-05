library main;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:di/di.dart';



class MyAppModule extends Module {
  MyAppModule() {
  }
}

Injector inj;

void main() {
  inj = applicationFactory().addModule(new MyAppModule()).run();
}

