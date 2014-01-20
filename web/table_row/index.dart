library main;

import 'dart:html';
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
    template: '''<content></content><span>{{ctrl.value.name}}</span><span> - </td><td>{{ctrl.value}}</span>'''
)
class MyTrComponent extends NgShadowRootAware{
  @NgTwoWay('param') Item value;

  MyTrComponent() {
    print('MyTrComponent');
  }

  @override
  void onShadowRoot(ShadowRoot shadowRoot) {
    var elements = new List<Element>.from(shadowRoot.children.where((e) => !(e is StyleElement) && !(e is ContentElement)));
    ContentElement ce = shadowRoot.querySelector('content');
    elements.forEach((e) {
      e.remove();
      var td = new TableCellElement();
      td.append(e);
      print('append: ${e.tagName}');
      ce.append(td);
    });
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
