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

class MyComponent {
  List<Item> values = [new Item('1'), new Item('2'), new Item('3'), new Item('4')];

  MyComponent() {
    print('MyComponent');
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
