library main;

import 'dart:html' as dom;
import 'dart:async';
import 'package:angular/angular.dart';
import 'package:di/di.dart';

import 'event_bus.dart';

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

  void add(String value) {
    values.add(new Item(value));
  }

  EventBus _eb;

  MyComponent(this._eb) {
    print('MyComponent');
    _eb.on(Events.someEvent).listen((e) => add(e));
    _eb.on(Events.someEventWithData).listen((SomeEventData ed) {
      print('Event received from ${ed.senderId}');
      ed.respond(this);
    });
  }
}


typedef MyComponentEventResponse (MyComponent component);
class SomeEventData {
  SomeEventData(this.respond, this.someOtherData, [this.senderId]);
  MyComponentEventResponse respond;
  var someOtherData;
  String senderId;
}

class Events {
  static final EventType<String> someEvent = new EventType<String>("someEvent");
  static final EventType<SomeEventData> someEventWithData = new EventType<SomeEventData>("someEventWithData");
}

class MyAppModule extends Module {
  MyAppModule() {
    type(MyComponent);
    value(EventBus, new EventBus());
  }
}

void main() {
  Injector inj = ngBootstrap(module: new MyAppModule());

  EventBus eb = inj.get(EventBus);

  eb.fire(Events.someEvent, "17");
  new Timer(new Duration(milliseconds: 1000), () => eb.fire(Events.someEvent, "33"));
  new Timer(new Duration(milliseconds: 2000), () => eb.fire(Events.someEventWithData, new SomeEventData(respond, 'blabla', 'main105')));
}

void respond(MyComponent c) {
  dom.window.alert('Demonstrate access to event receiver: Name of 2nd item: ${c.values[1].name}');
}
