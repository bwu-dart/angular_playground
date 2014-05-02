library angular_default_header.main;

import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

@ng.Component(selector: 'web-sandbox-component',
    publishAs: 'ctrl',
    template: '<div><span><input type="text" ng-model="ctrl.value"></input><span></div>')
class Comp {
  Comp() {
    print('comp');
  }

  String _value = 'blabla';
  String get value {
    print("get value $_value");
    return _value;
  }

  void set value(String val) {
    print("set value $val");
    _value = val;
  }
}


class MyAppModule extends ng.Module {
  MyAppModule() {
    type(Comp);
  }
}

main() {
  print('main');
  ng.Injector inj = ngaf.applicationFactory().addModule(new MyAppModule()).run();
  var node = dom.querySelector('#div');
  node.append(new dom.Element.html('<web-sandbox-component></web-sandbox-component>', validator: new dom.NodeValidatorBuilder()..allowCustomElement("web-sandbox-component")));
  ng.Compiler compiler = inj.get(ng.Compiler);
  ng.DirectiveMap directiveMap = inj.get(ng.DirectiveMap);
  compiler(node.childNodes, directiveMap)(inj, node.childNodes);
}
