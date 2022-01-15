import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'logic/cubit/internet_cubit.dart';

import 'logic/cubit/counter_cubit.dart';
import 'logic/cubit/settings_cubit.dart';
import 'logic/utility/app_bloc_observer.dart';
import 'presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // Bloc.observer = AppBlocObserver();
  // BlocOverrides.runZoned(
  //   () => runApp(MyApp(
  //     appRouter: AppRouter(),
  //     connectivity: Connectivity(),
  //   )),
  //   blocObserver: AppBlocObserver(),
  // );

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
      connectivity: Connectivity(),
    )),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;
  const MyApp({required this.appRouter, required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (context) => SettingsCubit(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // routes: {
        //   '/': (context) => BlocProvider.value(
        //         value: _counterCubit,
        //         child: HomeScreen(
        //           title: '1st',
        //           color: Colors.blueAccent,
        //         ),
        //       ),
        //   '/second': (context) => BlocProvider.value(
        //         value: _counterCubit,
        //         child: SecondScreen(
        //           title: '2nd',
        //           color: Colors.green,
        //         ),
        //       ),
        //   '/third': (context) => BlocProvider.value(
        //         value: _counterCubit,
        //         child: ThirdScreen(
        //           title: '3rd',
        //           color: Colors.red,
        //         ),
        //       )
        // },
        // home: const HomeScreen(
        //     title: 'Flutter Demo Home Page', color: Colors.blueAccent),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
