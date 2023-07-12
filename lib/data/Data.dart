import 'package:wallpaperapplication/model/Categories_model.dart';

String apiKey = "563492ad6f917000010000010e0d937af8f542779ae5f4fa67b9c066";
List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = [];
  CategoriesModel categoriesModel = new CategoriesModel();
  //
  categoriesModel.ImageURL =
      "https://images.pexels.com/photos/162379/lost-places-pforphoto-leave-factory-162379.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categorieName = "Street Art";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();
  //
  categoriesModel.ImageURL =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categorieName = "Wild Life";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();
  //
  categoriesModel.ImageURL =
      "https://images.pexels.com/photos/572688/pexels-photo-572688.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categorieName = "Nature";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();
  //
  categoriesModel.ImageURL =
      "https://images.pexels.com/photos/609749/pexels-photo-609749.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categorieName = "Wild life";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();
  return categories;
}
