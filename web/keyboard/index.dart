library angular_observe_resize.main;

import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

@ng.Controller(selector: '[ng-controller="text-ctrl"]', publishAs: 'ctrl')
class TextController {
  String text;
}

@ng.Component(selector: 'keyboard', publishAs: 'cmp', templateUrl:
    'keyboard.html', cssUrl: 'css/keyboard.css')
class Keyboard {

  @ng.NgTwoWay('value')
  String text = "";
  bool get isShift => isLeftShift || isRightShift || isCapsLock;
  bool isLeftShift = false;
  bool isRightShift = false;
  bool isCapsLock = false;

  Keyboard();

  void onClick(dom.MouseEvent e) {
    // workaround for null assigned by AngularDart
    if(text == null) {
      text = "";
    }
    var elm = (e.target as dom.HtmlElement);

    if(elm is dom.SpanElement) {
      elm = elm.parent;
    }

    String key;
    if (elm.classes.contains('symbol')) {
      key = elm.querySelector('.off').innerHtml;
      text += key;
    } else {
      key = elm.innerHtml;
    }

    if(elm.classes.contains('delete') && elm.classes.contains('lastitem')) {
      if(text.length > 0) {
        text = text.substring(0, text.length - 1);
      }
    }

    if(elm.classes.contains('tab')) {
      text += '\t';
    }

    if(elm.classes.contains('return')) {
      text += '\n';
    }

    if(elm.classes.contains('space')) {
      text += ' ';
    }

    if(elm.classes.contains('letter')) {
      if(isShift) {
        text += key.toUpperCase();
      } else {
        text += key;
      }
    }

    if(elm.classes.contains('capslock')) {
      isCapsLock =! isCapsLock;
    }

    if(elm.classes.contains('left-shift')) {
      isCapsLock = false;
      isRightShift = false;
      isLeftShift = !isLeftShift;
    }

    if(elm.classes.contains('right-shift')) {
      isCapsLock = false;
      isLeftShift = false;
      isRightShift = !isRightShift;
    }

    if(!(elm.classes.contains('left-shift') || elm.classes.contains('right-shift'))) {
      isLeftShift = false;
      isRightShift = false;
    }
  }
}

class MyAppModule extends ng.Module {
  MyAppModule() {
    type(Keyboard);
    type(TextController);
  }
}

main() {
  print('main');
  ngaf.applicationFactory().addModule(new MyAppModule()).run();
}
