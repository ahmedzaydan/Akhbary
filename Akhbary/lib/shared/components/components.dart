// ignore_for_file: avoid_print
import 'package:akhbary/models/article_model.dart';
import 'package:akhbary/modules/categories/categories_cubit/categories_cubit.dart';
import 'package:akhbary/modules/categories/category_screen.dart';
import 'package:akhbary/shared/components/constants.dart';
import 'package:akhbary/shared/styles/color.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../modules/webview_screen.dart';

// custom TextFormField
Widget myTextFormField({
  required TextEditingController textController,
  required TextInputType keyboardType,
  bool isPassword = false,
  required Icon prefixIcon,
  IconButton? suffixIcon,
  required String label,
  required Function(String?) validator,
  Function(String value)? myOnFieldSubmitted,
  Function(String value)? myOnChanged,
  VoidCallback? myOnTap,
  double borderRadius = 25.0,
  bool myEnabled = true,
  required context,
}) {
  return TextFormField(
    style: Theme.of(context).textTheme.bodyLarge,
    controller: textController,
    keyboardType: keyboardType,
    obscureText: isPassword,
    validator: (String? value) => validator(value),
    decoration: InputDecoration(
      // hintStyle: Theme.of(context).textTheme.bodyLarge,
      prefixIcon: prefixIcon,
      labelText: label,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    onFieldSubmitted: myOnFieldSubmitted,
    onChanged: myOnChanged,
    onTap: myOnTap,
    enabled: myEnabled,
    autofocus: true,
  );
}

// search bar
Widget searchBar(context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: SizedBox(
      height: 48,
      width: double.infinity,
      child: TextFormField(
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          filled: true,
          focusColor: Colors.blue,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              width: 3.0,
              color: Colors.blue,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              width: 3.0,
              color: Colors.white,
            ),
          ),
          prefixIcon: IconButton(
            icon: Icon(
              Icons.search,
              size: 20,
              color: Colors.grey[600],
            ),
            onPressed: () {},
          ),
          hintText: "Search",
        ),
        onFieldSubmitted: (value) {},
      ),
    ),
  );
}

Widget verticalSeparator({double value = 10}) => Container(
      height: value,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
    );

Widget horizontalSeparator({double value = 10}) => SizedBox(width: value);

// build article item
Widget buildArticleItem({
  required ArticleModel article,
  required BuildContext context,
  TextAlign align = TextAlign.right,
}) {
  CategoriesCubit categoriesCubit = CategoriesCubit.getCategoriesCubit(context);
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 150,
      width: double.infinity,
      // InkWell to make article clickable
      child: InkWell(
        onTap: () {
          navigateTo(
            context: context,
            destination: WebViewScreen('${article.url}'),
          );
        },
        child: Row(
          children: [
            // article photo
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      article.urlToImage != null
                          ? '${article.urlToImage}'
                          : breakingNewsPhoto,
                    ),
                  )),
            ),

            const SizedBox(
              width: 20,
            ),

            // article title + publishing date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // title
                  Text(
                    '${article.title}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: align,
                    // Theme.of(context) gets the current theme
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  // publishing date + favorites + read
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          article.publishedAt.toString().substring(0, 9),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // favorites icon
                      IconButton(
                        onPressed: () {
                          categoriesCubit.addToFavorites(
                            articleID: article.id,
                            articleCategory: article.category!,
                          );
                        },
                        icon: Icon(
                          article.favorites ? Icons.star : Icons.star_outline,
                        ),
                      ),

                      // read icon
                      IconButton(
                        onPressed: () {
                          categoriesCubit.markArticleRead(
                            articleID: article.id,
                            articleCategory: article.category!,
                          );
                        },
                        icon: Icon(
                          article.read
                              ? Icons.mark_chat_read
                              : Icons.mark_chat_read_outlined,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// build articles screen
Widget buildArticles({
  required List<dynamic> list,
  required BuildContext buildContext,
  bool isSearch = false,
  TextAlign align = TextAlign.right,
}) {
  return ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (BuildContext context) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(
        article: list[index],
        context: buildContext,
        align: align,
      ),
      separatorBuilder: (context, index) => verticalSeparator(value: 2),
      itemCount: list.length,
    ),
    fallback: (BuildContext context) => isSearch
        ? Container()
        : const Center(child: CircularProgressIndicator()),
  );
}

// navigator function

void navigateTo({
  required BuildContext context,
  required Widget destination,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => destination,
    ),
  );
}

Widget buildCategory({
  required String categoryName,
  required BuildContext context,
}) {
  // NewsCubit newsCubit = NewsCubit.getNewsCubit(context);
  CategoriesCubit categoriesCubit = CategoriesCubit.getCategoriesCubit(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: lightThemeColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          // get the index of clicked category
          int categoryIndex = categoriesCubit.categoriesNames.indexWhere(
            (category) {
              return category == categoryName;
            },
          );
          String category = categoriesCubit
              .categoriesNames[categoryIndex]; // get the category name
          // get data based on category
          categoriesCubit.changeCategoryName(
            categoryName: category,
          );

          navigateTo(
            context: context,
            destination: const CategoryScreen(),
          );
        },
        child: Text(
          categoryName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    ),
  );
}
