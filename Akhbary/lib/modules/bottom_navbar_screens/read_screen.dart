import 'package:akhbary/modules/categories/categories_cubit/categories_cubit.dart';
import 'package:akhbary/modules/categories/categories_cubit/categories_states.dart';
import 'package:akhbary/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CategoriesCubit categoriesCubit =
            CategoriesCubit.getCategoriesCubit(context);
        var list = categoriesCubit.readData;
        return ConditionalBuilder(
          condition: list.isNotEmpty,
          builder: (context) => buildArticles(
            list: list,
            buildContext: context,
          ),
          fallback: (context) => Center(
            child: Text(
              "There is no read items yet!.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        );
      },
    );
  }
}
