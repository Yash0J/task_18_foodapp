import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/recipe_api.dart';
import 'widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu_rounded,
              color: Colors.black,
              size: 20,
            ),
            SizedBox(width: 10),
            Text('Food Recipes'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _recipes.isEmpty
              ? const Center(child: Text('No recipes available'))
              : ListView.builder(
                  itemCount: _recipes.length,
                  itemBuilder: (context, index) {
                    return RecipeCard(
                      title: _recipes[index].name,
                      cookTime: _recipes[index].totalTime,
                      rating: _recipes[index].rating.toString(),
                      thumbnailUrl: _recipes[index].images,
                    );
                  },
                ),
    );
    //   body: _isLoading
    //       ? const Center(child: CircularProgressIndicator())
    //       : ListView.builder(
    //           itemCount: _recipes.length,
    //           itemBuilder: (context, index) {
    //             return RecipeCard(
    //                 title: _recipes[index].name,
    //                 cookTime: _recipes[index].totalTime,
    //                 rating: _recipes[index].rating.toString(),
    //                 thumbnailUrl: _recipes[index].images);
    //           },
    //         ),
    // );
    //   body: _isLoading
    //       ? const Center(child: CircularProgressIndicator())
    //       : const RecipeCard(
    //           title: 'My recipe',
    //           rating: '4.9',
    //           cookTime: '30 min',
    //           thumbnailUrl:
    //               'https://lh3.googleusercontent.com/ei5eF1LRFkkcekhjdR_8XgOqgdjpomf-rda_vvh7jIauCgLlEWORINSKMRR6I6iTcxxZL9riJwFqKMvK0ixS0xwnRHGMY4I5Zw=s360',
    //         ),
    // );
  }
}
