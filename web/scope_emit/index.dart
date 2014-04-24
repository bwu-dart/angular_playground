library main;

import 'package:angular/angular.dart';
import 'package:di/di.dart';

class Item {
  String name;
  Item(this.name);
}

@NgComponent(
    selector: 'my-component',
    publishAs: 'ctrl',
    applyAuthorStyles: true,
    template: '''<div ng-repeat="value in ctrl.values"><span>{{value.name}}</span> - <content><content></div>'''
)

class MyComponent implements NgAttachAware {
  List<Item> values = [new Item('1'), new Item('2'), new Item('3'), new Item('4')];

  String roomName = 'room 1';
  Scope _scope;

  MyComponent(this._scope) {
    print('MyComponent');
  }

  @override
  void attach() {
    _scope.$on('roomCreated', (ScopeEvent e, details x) {
      print(e);
    });
    _scope.$emit('roomCreated', ['${this.roomName}']);
  }
}


class MyAppModule extends Module {
  MyAppModule() {
    type(MyComponent);
  }
}

void main() {
  ngBootstrap(module: new MyAppModule());
}
