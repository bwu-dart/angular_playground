library main;

import 'package:angular/angular.dart';
import 'package:di/di.dart';

class Item {
  String name;
  Item(this.name);
}

@NgComponent(
    selector: 'tr[is=my-tr]',
    publishAs: 'ctrl',
    visibility: NgDirective.CHILDREN_VISIBILITY,
    applyAuthorStyles: true,
    template: '''<tr><td>{{ctrl.value.name}}</td><td> - </td><td>{{ctrl.value}}</td></tr>'''
)
class MyTrComponent {
  @NgTwoWay('param') Item value;

  MyTrComponent() {
    print('MyTrComponent');
  }
}

@NgController(
  selector: "[ng-controller=row-ctrl]",
  publishAs: "ctrl",
  visibility: NgDirective.CHILDREN_VISIBILITY
)
class RowController {
  List<Item> values = [new Item('1'), new Item('2'), new Item('3'), new Item('4')];
  RowController() {
    print('RowController');
  }
}

class MyAppModule extends Module {
  MyAppModule() {
    type(MyTrComponent);
    type(RowController);
  }
}

void main() {
  ngBootstrap(module: new MyAppModule());
}



//    var template = _compiler.call(_element.shadowRoot.children);
//  template(_injector, _element.shadowRoot);
