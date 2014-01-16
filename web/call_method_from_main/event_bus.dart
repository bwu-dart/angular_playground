/**
 * Derived from https://github.com/marcojakob/dart-event-bus
 */
library eventbus;

import "dart:async";
import "dart:html";

import "package:logging/logging.dart";

/**
 * [EventBus] is a central event hub.
 * In addition it automatically updates the page navigation history ([History]
 * by calling [window.pushState] for fired events which indicate, that they
 * are supposed to update the [History] and refiring events which led to
 * [window.pushState] in the case of a [window.onPopState] event.
 */
class EventBus extends Object {
  final _logger = new Logger("EventBusModel");

  /**
   * A [StreamController] is maintained for each event type.
   */
  Map<EventType, StreamController> streamControllers = new Map<EventType, StreamController>();

  bool isSync = true;

  /**
   * Constructs an [EventBus] and allows to specify if the events should be
   * send synchroniously or asynchroniously by setting [isSync].
   */
  EventBus({this.isSync : false});

  /**
   * [on] allows to access an stream for the specified [eventType].
   */
  Stream/*<T>*/ on(EventType/*<T>*/ eventType) {
    _logger.finest('on');

    return streamControllers.putIfAbsent(eventType, () {
      return new StreamController.broadcast(sync: isSync);
      }
    ).stream;
  }

  /**
   * [fire] broadcasts an event of a type [eventType] to all subscribers.
   */
  void fire(EventType/*<T>*/ eventType, /*<T>*/ data) {
    _logger.finest('event fired: ${eventType.name}');

    if (data != null && !eventType.isTypeT(data)) {
      throw new ArgumentError('Provided data is not of same type as T of EventType.');
    }

    var controller = streamControllers[eventType];
    if (controller != null) {
      controller.add(data);
    }
  }
}

/**
 * Type class used to publish events with an [EventBus].
 * [T] is the type of data that is provided when an event is fired.
 */
class EventType<T> {

  String name;

  /**
   * Constructor with an optional [name] for logging purposes.
   */
  EventType(this.name);

  /**
   * Returns true if the provided data is of type [T].
   *
   * This method is needed to provide type safety to the [EventBus] as long as
   * Dart does not support generic types for methods.
   */
  bool isTypeT(data) => data is T;
}

