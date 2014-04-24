library main;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:di/di.dart';

@NgController(
    selector: '[ng-controller=alert-demo-ctrl]',
    publishAs: 'ctrl')
class AlertDemoController {
  WebSocketWrapper1 _wsw1;

  AlertDemoController(this._wsw1) {
  }

  String sendData() {
    _wsw1.ws.send("somedata");
  }
}

@NgController(
    selector: '[ng-controller=accordion-demo-ctrl]',
    publishAs: 'ctrl')
class AccordionDemoController {
  WebSocketWrapper2 _wsw2;

  AccordionDemoController(this._wsw2) {
  }

  String sendData() {
    _wsw2.ws.send("somedata");
  }
}

@NgController(
    selector: '[ng-controller=tabs-demo-ctrl]',
    publishAs: 'ctrl')
class TabsDemoController {
  WebSocketOnDemandWrapper2 _wsodw1;

  TabsDemoController(this._wsodw1) {
  }

  String sendData() {
    _wsodw1.ws.send("somedata");
  }
}


class WebSocketWrapper1 {
  WebSocket ws;
  WebSocketWrapper1(this.ws);
}

class WebSocketWrapper2 {
  WebSocket ws;
  WebSocketWrapper2(this.ws);
}

class WebSocketOnDemandWrapper1 {
  WebSocket ws;
  WebSocketOnDemandWrapper1(){
    ws = new WebSocket('ws://127.0.0.1:1337/ws');
  }
}

class WebSocketOnDemandWrapper2 {
  WebSocket ws;
  WebSocketOnDemandWrapper2(){
    ws = new WebSocket('ws://127.0.0.1:3173/ws');
  }
}


class MyAppModule extends Module {
  MyAppModule() {
    type(AlertDemoController);
    type(AccordionDemoController);
    type(TabsDemoController);
    type(WebSocketOnDemandWrapper1);
    type(WebSocketOnDemandWrapper2);
    value(WebSocketWrapper1, new WebSocketWrapper1(new WebSocket('ws://127.0.0.1:1337/ws')));
    value(WebSocketWrapper2, new WebSocketWrapper2(new WebSocket('ws://127.0.0.1:3173/ws')));
  }
}

void main() {
  ngBootstrap(module: new MyAppModule());
}
