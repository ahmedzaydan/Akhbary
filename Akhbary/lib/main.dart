import 'package:akhbary/modules/categories/categories_cubit/categories_cubit.dart';
import 'package:akhbary/shared/bloc_observer.dart';
import 'package:akhbary/shared/cubit/news_cubit.dart';
import 'package:akhbary/shared/cubit/news_states.dart';
import 'package:akhbary/shared/network/local/cache_controller.dart';
import 'package:akhbary/shared/network/remote/api_handler.dart';
import 'package:akhbary/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/home_layout_screen.dart';
import 'modules/categories/categories_cubit/categories_states.dart';

// main is async as CacheController.init() is async
void main() async {
  // this function guarantee that all content of body of main will run then function runApp() will called
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  // create dio object when starting the app
  APIHandler.init();

  // create shared preferences object when starting the app
  await CacheController.init();

  bool? isDarkModeOn = CacheController.getBoolean(key: 'switchValue');

  runApp(AkhbaryApp(isDarkModeOn));
}

class AkhbaryApp extends StatelessWidget {
  final bool? isDarkMode;

  const AkhbaryApp(this.isDarkMode, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider enables you to provide (create object from) more than one bloc at the same time
    return MultiBlocProvider(
      providers: [
        // send to shared preferences when launching the app
        BlocProvider(
          create: (context) {
            return NewsCubit()..setSwitchValue(darkMode: isDarkMode);
          },
        ),
        BlocProvider(
          create: (context) {
            return CategoriesCubit();
          },
        )
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.getNewsCubit(context);
          return BlocConsumer<CategoriesCubit, CategoriesStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                home: HomeLayout(),
                debugShowCheckedModeBanner: false,
                theme: lightTheme(),
                darkTheme: darkTheme(),
                themeMode: cubit.switchValue ? ThemeMode.dark : ThemeMode.light,
              );
            },
          );
        },
      ),
    );
  }
}
