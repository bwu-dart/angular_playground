library main;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:di/di.dart';

@Controller(
  selector: '[ng-controller=demo-ctrl]',
  publishAs: 'ctrl'
)
class DemoCtrl {
  var list = [[1,2,3,4,5],['a','b','c','d'],['A','B','C']];
}


class MyAppModule extends Module {
  MyAppModule() {
    type(DemoCtrl);
  }
}

Injector inj;

void main() {
  applicationFactory().addModule(new MyAppModule()).run();
}

