import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dummyjson/model/comments.dart';
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

  //posts
  PostsModel? postsModel;

  // comments
  CommentsModel? commentsModel;
  bool commentIsLoading = false;
  bool commentisError = false;
  String? commenterrorMessage;

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

  Future<void> fetchComments(int id) async {
    try {
      commentIsLoading = true;
      update();
      commentisError = false;
      commenterrorMessage = null;

      final response = await http.get(
        Uri.parse('$url/comments/post/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final parseJson = json.decode(response.body);
        commentsModel = CommentsModel.fromJson(parseJson);

        commentisError = false;
        commenterrorMessage = null;
      } else {
        commenterrorMessage = jsonDecode(response.body)['message'];
        commentisError = true;
      }
    } catch (e) {
      if (e is SocketException) {
        commenterrorMessage = 'Please check your network and try again';
      } else if (e is TimeoutException) {
        commenterrorMessage = 'Taking longer than usual. Try again?';
      } else {
        commenterrorMessage = 'Something went wrong.';
      }
      commentisError = true;
    } finally {
      commentIsLoading = false;
    }

    update();
  }
}
