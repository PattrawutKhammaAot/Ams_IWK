import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'blocs/home/home.dart';
import 'blocs/network/network.dart';
import 'config/app_data.dart';
import 'data/models/api_response.dart';
import 'routes/route.dart';
import 'screens/login/bloc/auth_bloc.dart';
import 'screens/splash/view/splash_page.dart';
import 'themes/theme.dart';
import 'widgets/alert.dart';

enum ViewType { online, offline }

enum FetchStatus {  connectionFailed, fetching, sending, success, failed, init, saved, sendSuccess, sendFailed, removeSuccess }

class GlobalContextService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    //action bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()..add(HomeObserve())),
        BlocProvider(create: (_) => NetworkBloc()..add(NetworkObserve())),
        BlocProvider(create: (_) => AuthBloc()..add(AuthObserve())),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  //final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => GlobalContextService.navigatorKey.currentState!;
  final botToastBuilder = BotToastInit();
  final easyLoading = EasyLoading.init();

  @override
  Widget build(BuildContext context) {
    EasyLoading
        .instance
        // ..displayDuration = const Duration(milliseconds: 2000)
        // ..indicatorType = EasyLoadingIndicatorType.fadingCircle
        // ..loadingStyle = EasyLoadingStyle.dark
        // ..indicatorSize = 45.0
        // ..radius = 10.0
        // ..progressColor = Colors.yellow
        // ..backgroundColor = Colors.green
        // ..indicatorColor = Colors.yellow
        // ..textColor = Colors.yellow
        .userInteractions = false;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      navigatorKey: GlobalContextService.navigatorKey,
      //routes: routes,
      getPages: routes,

      builder: (context, child) {
        child = BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthInitial) {
              String _test = await AppData.getToken();
              if (_test != ""){
                Get.toNamed('/');
              }else{
                Get.toNamed('/Login');
              }
            }
          },
          child: BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              if (state is NetworkFailure) {
                 AppData.setMode("Offline");
                Alert.show(title: 'Connection Failed', message: 'Check your internet connection and try again ', type: ReturnStatus.ERROR, duration: const Duration(seconds: 10));
              } else if (state is NetworkSuccess) {
                AppData.setMode("Online");
                 Alert.show(title: 'Connection Successful', message: 'You\'re Online Now', type: ReturnStatus.SUCCESS, duration: const Duration(seconds: 5));
              }
            },
            child: child,
          ),
        );
        child = botToastBuilder(context, child);
        child = easyLoading(context, child);

        return child;
      },

      onGenerateRoute: (_) => SplashPage.route(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}