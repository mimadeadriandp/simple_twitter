import 'package:event_bus/event_bus.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../app_component.dart';

class BaseController extends Controller {
  EventBus eventBus = AppComponent.getInjector().getDependency<EventBus>();
  // UserData userData = AppComponent.getInjector().getDependency<UserData>();
  bool internetAvailable = true;
  bool isLoading = false;

  @override
  void initListeners() {
  }

  void internetAvailabilityCycle(bool status) {
    if (status) {
      internetAvailable = status;
      onInternetDisconnected();
    } else {
      internetAvailable = status;
      onInternetConnected();
    }
  }


  void onInternetConnected() {}

  void onInternetDisconnected() {}

  void onProgressLoading() {}

  void onFinishLoading() {}

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  void showLoading() {
    isLoading = true;
    refreshUI();
  }
}
