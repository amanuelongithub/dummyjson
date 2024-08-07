import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dummyjson/model/posts_model.dart';
import 'package:dummyjson/model/products_model.dart';
import 'package:dummyjson/view/widgets/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  bool isLoading = false;
  bool isError = false;
  bool socketExc = false;
  String? errorMessage;

  // products
  ProductsModel? productsModel;

  int productsPageIndex = 0;
  int productsCurrentPage = 0;
  bool productsPaginatedLoading = false;

  //posts
  PostsModel? postsModel;

  int postsPageIndex = 0;
  int postsCurrentPage = 0;
  bool postsPaginatedLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading = true;
      update();

      isError = false;
      errorMessage = null;
      socketExc = false;

      await Future.wait([
        fetchProducts(),
        fetchPost(),
      ]);
    } catch (e) {
      errorMessage = 'Something went wrong';
      isError = true;
    } finally {
      isLoading = false;
    }
    update();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$url/products/?limit=10'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final parseJson = json.decode(response.body);
        productsModel = ProductsModel.fromJson(parseJson);
        productsCurrentPage = productsModel!.limit!;

        isError = false;
        errorMessage = null;
      } else {
        errorMessage = jsonDecode(response.body)['message'];
        isError = true;
      }
    } catch (e) {
      if (e is SocketException) {
        errorMessage = 'Please check your network and try again';
      } else if (e is TimeoutException) {
        errorMessage = 'Taking longer than usual. Try again?';
      } else {
        errorMessage = 'Something went wrong.';
      }
      isError = true;
    }

    update();
  }

  Future<void> fetchPaginatedProductes() async {
    if (30 > productsPageIndex) {
      productsPageIndex += 10;
      try {
        productsPaginatedLoading = true;
        update();

        Map<String, String> headers = {
          'Content-Type': 'application/json',
        };

        final response = await http.get(
          Uri.parse('$url/products/?limit=10&skip=$productsPageIndex'),
          headers: headers,
        );
        if (response.statusCode == 200) {
          final parseJson = json.decode(response.body);
          var temp = ProductsModel.fromJson(parseJson);

          for (var product in temp.products!) {
            productsModel!.products!.add(product);
          }

          productsCurrentPage = productsModel!.limit!;

          isError = false;
          errorMessage = null;
        }
      } catch (e) {
        productsPageIndex -= 10;
      } finally {
        productsPaginatedLoading = false;
      }
    }

    update();
  }

  Future<void> fetchPost() async {
    try {
      final response = await http.get(
        Uri.parse('$url/posts'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final parseJson = json.decode(response.body);
        postsModel = PostsModel.fromJson(parseJson);

        isError = false;
        errorMessage = null;
      } else {
        errorMessage = jsonDecode(response.body)['message'];
        isError = true;
      }
    } catch (e) {
      if (e is SocketException) {
        errorMessage = 'Please check your network and try again';
      } else if (e is TimeoutException) {
        errorMessage = 'Taking longer than usual. Try again?';
      } else {
        errorMessage = 'Something went wrong.';
      }
      isError = true;
    }

    update();
  }

}
