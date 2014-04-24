library angular_observe_resize.main;

import 'dart:async' as async;
import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

@ng.Controller(
    selector: '[some-ctrl]',
    publishAs: 'ctrl')
class MyCtrl {
  MyCtrl() {
    print('MyCtrl created');
  }
  int graphWidth = 50;
  String data = "someData";
}

@ng.Component(
  selector: 'loading',
  publishAs: 'cmp',
  template:'''
<div>z
  <content></content>
</div>z
'''
)
class Loading {
  Loading() {
    new async.Future.delayed(new Duration(seconds: 3), () => done = true);
    new async.Future.delayed(new Duration(seconds: 6), () => error = "blabla");
  }
  String error;
  bool done;
}

@ng.Component(
  selector: 'graph',
  publishAs: 'cmp',
  template:'''
<div>x<span>{{cmp.width}}</span>xy<span>{{cmp.data}}</span>y</div>
'''
)
class Graph {
  @ng.NgOneWay('width')
  int width;
  @ng.NgOneWay('data')
  String data;
}


class MyAppModule extends ng.Module {
  MyAppModule() {
    type(MyCtrl);
    type(Loading);
    type(Graph);
  }
}

main() {
  print('main');
  ngaf.applicationFactory().addModule(new MyAppModule()).run();
}
