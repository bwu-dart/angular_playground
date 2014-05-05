library main;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:di/di.dart';

class Item {
  String name;
  Item(this.name);
}

@Component(
    selector: 'my-component',
    publishAs: 'ctrl',
    applyAuthorStyles: true,
    template: '''<div ng-repeat="value in ctrl.values"><span>{{value.name}}</span> - <content><content></div>'''
)

class MyComponent implements AttachAware {
  List<Item> values = [new Item('1'), new Item('2'), new Item('3'), new Item('4')];

  String roomName = 'room 1';
  Scope _scope;

  MyComponent(this._scope) {
    print('MyComponent');
  }

  @override
  void attach() {
    _scope.on('roomCreated').listen((ScopeEvent e) {
      print(e);
    });
    _scope.emit('roomCreated', ['${this.roomName}']);
  }
}


class MyAppModule extends Module {
  MyAppModule() {
    type(MyComponent);
  }
}

void main() {
  applicationFactory().addModule(new MyAppModule()).run();
}
