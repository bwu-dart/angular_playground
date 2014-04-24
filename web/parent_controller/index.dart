library angular_default_header.main;

import 'dart:async' as async;
import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

@ng.Controller(
  selector: '[main-ctrl]',
  publishAs: 'ctrl')
class MainController {
  ng.Scope scope;
  bool showHeaderFooter=false;
  MainController(this.scope) {
    //scope.context['mainCtrl'] = this;
    scope.on('login').listen((e) => showHeaderFooter = e.data);
    // just for demonstration
    new async.Timer.periodic(new Duration(seconds: 1), (e) => print(showHeaderFooter));
  }

}

@ng.Controller(
selector: '[login-ctrl]',
publishAs: 'login')
class LoginController {
  ng.Scope scope;
  ng.NgRoutingHelper routingHelper;
  var username, pwd;

  LoginController(this.routingHelper,this.scope);

  void login(){
//    if(username!=null&&pwd!=null){
      //routingHelper.router.go('welcome', {});
//      (scope.parentScope.context['mainCtrl'] as MainController).showHeaderFooter=true;
    scope.emit('login', true);
//    }
  }
}

class MyAppModule extends ng.Module {
  MyAppModule() {
    type(MainController);
    type(LoginController);
  }
}

main() {
  print('main');
  var ul = dom.document.querySelector('ul');
//  new MutationObserver(mutationCallback).observe(ul, childList: true);
  ngaf.applicationFactory().addModule(new MyAppModule()).run();
}
