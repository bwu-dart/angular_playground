library main;

import 'dart:html' as dom;
import 'package:angular/angular.dart';
import 'package:di/di.dart';

@Controller(
  selector: '[ng-controller=demo-ctrl]',
  publishAs: 'ctrl'
)
class DemoCtrl {
  dom.FileList _file;
  dynamic get file {
    return _file;
  }
  set file(file) {
    _file = file;
  }
}

@Directive(selector: 'input[type=file][ng-model]')
class InputFileDirective {
  dom.InputElement inputElement;
  NgModel ngModel;
  Scope scope;

  InputFileDirective(dom.Element this.inputElement, this.ngModel, this.scope) {
    ngModel.render = (value) {
      inputElement.files = value;
    };
    inputElement.onChange.listen((value) {
      scope.$apply(() => ngModel.viewValue = inputElement.files);
    });
  }
}


class MyAppModule extends Module {
  MyAppModule() {
    type(DemoCtrl);
    type(InputFileDirective);
  }
}

Injector inj;

void main() {
  ngBootstrap(module: new MyAppModule());
}

