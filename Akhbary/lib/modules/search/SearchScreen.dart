import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/news_cubit.dart';
import '../../shared/cubit/news_states.dart';


class SearchScreen extends StatelessWidget {
  var searchedDataController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BuildContext sentContext = context;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.getNewsCubit(context);
        var list = cubit.searchData;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              // search bar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: myTextFormField(
                  context: sentContext,
                  textController: searchedDataController,
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.search),
                  label: 'Search',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Search data must not be empty';
                    } else {
                      return null;
                    }
                  },
                  myOnChanged: (value) {
                    cubit.getSearchedData(
                      query: value,
                    );
                  },
                ),
              ),

              // body of the screen
              Expanded(
                  child: buildArticles(
                list: list,
                buildContext: sentContext,
                align: TextAlign.left,
                isSearch: true,
              ))
            ],
          ),
        );
      },
    );
  }
}

