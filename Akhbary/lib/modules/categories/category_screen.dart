import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import 'categories_cubit/categories_cubit.dart';
import 'categories_cubit/categories_states.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<CategoriesCubit, CategoriesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CategoriesCubit categoriesCubit =
              CategoriesCubit.getCategoriesCubit(context);
          var list = categoriesCubit.categoriesData[categoriesCubit.category]!;
          return buildArticles(list: list, buildContext: context);
        },
      ),
    );
  }
}
