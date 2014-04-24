library main;

import 'package:angular/angular.dart';
import 'package:di/di.dart';



class MyAppModule extends Module {
  MyAppModule() {
  }
}

Injector inj;

void main() {
  ngBootstrap(module: new MyAppModule());
}

