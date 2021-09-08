import 'package:injector/injector.dart';
import 'package:simple_twitter/app/ui/pages/home/controller.dart';
import 'package:simple_twitter/app/ui/pages/login/controller.dart';

class ControllerModule {
  static void init(Injector injector) {
    injector.registerDependency<AuthController>((Injector injector) {
      return AuthController();
    });
    injector.registerDependency<HomeController>((Injector injector) {
      return HomeController();
    });
}
}