import 'package:event_bus/event_bus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:simple_twitter/app/ui/pages/login/view.dart';
import 'package:simple_twitter/app/ui/res/generated/i18n.dart';
import 'package:simple_twitter/app/ui/widgets/custom_dialog.dart';
import 'package:simple_twitter/app/ui/widgets/loading.dart';
import 'infrastructures/app_component.dart';
import 'infrastructures/event/error.dart';
import 'infrastructures/event/loading_event.dart';
import 'infrastructures/router.dart' as MyRouter;
import 'package:rxdart/subjects.dart';

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

main() async {
  AppComponent.init(); // init dependency
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp()); // run app
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final MyRouter.Router _router;
  final EventBus _eventBus =
      AppComponent.getInjector().getDependency<EventBus>();
  static bool isConnectedToInternet = true;
  final _navigatorKey = GlobalKey<NavigatorState>();

  MyApp() : _router = MyRouter.Router() {
    _initEventListeners();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale('en'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }

  void _initEventListeners() {

    _eventBus.on<ErrorEvent>().listen((event) {
      showDialog(
        barrierDismissible: false,
        context: _navigatorKey.currentState.overlay.context,
        builder: (context) => WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: FailDialog(
              title: event.title,
              content: event.content,
              onConfirm: event.onConfirm,
              onConfirmText: event.confirmText),
        ),
      );
    });


    _eventBus.on<LoadingEvent>().listen((event) {
      showDialog(
        barrierDismissible: false,
        context: _navigatorKey.currentState.overlay.context,
        builder: (context) => WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: CommonLoading()),
      );
    });
    _eventBus.on<DismissLoadingEvent>().listen((event) {
      Navigator.of(_navigatorKey.currentState.overlay.context,
              rootNavigator: true)
          .pop();
    });

  }
}
