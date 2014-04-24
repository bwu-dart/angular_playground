library angular_default_header.main;

import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

@ng.Controller(selector: '[some-fruits]', publishAs: 'ctrl')
class Fruits {
  Fruits(){
    print('fruits created');
  }

  List elements = [['Apple', 'Banana', 'Orange', 'Kiwi'],
                   ['Audi', 'BMW', 'Mercedes', 'VW'],
                   ['Radio', 'TV', 'Phone']];

}


class MyAppModule extends ng.Module {
  MyAppModule() {
    type(Fruits);
  }
}

main() {
  print('main');
  ngaf.applicationFactory().addModule(new MyAppModule()).run();
}
