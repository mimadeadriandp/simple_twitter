import 'package:event_bus/event_bus.dart';
import 'package:injector/injector.dart';

// Commonly here to declare dependency injection
class RootModule {
  static void init(Injector injector) {

    injector.registerSingleton<EventBus>((Injector injector) {
      return EventBus();
    });



  }

}
