library angular_default_header.main;

import 'dart:async' as async;
import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

@ng.Controller(selector: '[somefruits]', publishAs: 'ctrl')
class Fruits {
  Fruits(){
    print('fruits created');
  }

  List fruits = ['Apple', 'Banana', 'Orange', 'Kiwi'];

  String dummy='';
  String foo(bool isLast) {
    print('foo: $isLast');
    new async.Future(() {
      //document.querySelector('.ng-last').style.border = '1px solid green';
    });
    return dummy;
  }
}


class MyAppModule extends ng.Module {
  MyAppModule() {
    type(Fruits);
  }
}

void mutationCallback(List<dom.MutationRecord> mutations, dom.MutationObserver observer) {
  mutations.forEach((mr) {
    mr.addedNodes.forEach((dom.Node n) {
      if(n is dom.Element) {
        if(n.classes.contains('ng-last')) {
          print('last added');
          observer.disconnect();
          n.style.border = '1px solid red';
        }
      }
    });
  });
}

main() {
  print('main');
  var ul = dom.document.querySelector('ul');
//  new MutationObserver(mutationCallback).observe(ul, childList: true);
  ngaf.applicationFactory().addModule(new MyAppModule());
}
