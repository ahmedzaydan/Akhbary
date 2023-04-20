import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/search_screen.dart';
import '../shared/components/components.dart';
import '../shared/cubit/news_cubit.dart';
import '../shared/cubit/news_states.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  int index = 0;

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    BuildContext buildContext = context;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var newsCubit = NewsCubit.getNewsCubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Akhbary",
              style: Theme.of(buildContext).textTheme.bodyLarge,
            ),
            actions: [
              // search button
              IconButton(
                onPressed: () {
                  navigateTo(context: context, destination: SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: newsCubit.screens[newsCubit.currentScreenIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: newsCubit.currentScreenIndex,
            onTap: (index) {
              newsCubit.changeScreenIndex(
                index: index,
              );
            },
            items: newsCubit.bottomItems,
          ),
        );
      },
    );
  }
}
