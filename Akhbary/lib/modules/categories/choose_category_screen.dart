import 'package:akhbary/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories_cubit/categories_cubit.dart';
import 'categories_cubit/categories_states.dart';

// ignore: must_be_immutable
class ChooseCategoryScreen extends StatelessWidget {
  const ChooseCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BuildContext buildContext = context;
    return Center(
      child: BlocConsumer<CategoriesCubit, CategoriesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CategoriesCubit categoriesCubit =
              CategoriesCubit.getCategoriesCubit(buildContext);
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Center(
              child: buildCategory(
                categoryName: categoriesCubit.categoriesNames[index],
                context: buildContext,
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: categoriesCubit.categoriesNames.length,
          );
        },
      ),
    );
  }
}
