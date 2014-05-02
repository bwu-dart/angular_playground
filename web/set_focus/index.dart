library main;

import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

@ng.Component(
  selector: 'my-comp',
  publishAs: 'ctrl',
  template: '''
<div>
  <input type="email" id="inputFirstName" >
  x<input type="email" id="inputFirstName"  autofocus>x
  <input type="email" id="inputFirstName" >
</div>'''
)
class MyComp {

}


@ng.Decorator(selector: '[autofocus]')
class AutoFocusDecorator implements ng.AttachAware{
  dom.InputElement inputElement;

  AutoFocusDecorator(dom.Element this.inputElement);

  @override
  void attach() {
    inputElement.focus();
  }
}


class MyAppModule extends ng.Module {
  MyAppModule() {
    type(AutoFocusDecorator);
    type(MyComp);
  }
}


void main() {
  ngaf.applicationFactory().addModule(new MyAppModule()).run();
}

