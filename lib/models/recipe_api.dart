import 'dart:convert';

import 'package:http/http.dart' as http;

import 'recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {
      "limit": "18",
      "start": "0",
      "tag": "list.recipe.popular",
    });

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "265d932c77msha378875aaf13249p165bf2jsnd59703aaf21f",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true",
    });

    Map data = jsonDecode(response.body);
    List<Map<String, dynamic>> _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}
