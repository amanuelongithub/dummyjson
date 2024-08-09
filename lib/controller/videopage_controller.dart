import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dummyjson/model/videodetail_model.dart';
import 'package:dummyjson/model/videos_model.dart';
import 'package:dummyjson/view/widgets/constant.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class VideoPageController extends GetxController {
  bool isLoading = false;
  bool isError = false;
  bool socketExc = false;
  String? errorMessage;

  VideosModel? videosModel;
  VideoDetailModel? videoDetailModel;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading = true;
      update();
      isError = false;
      errorMessage = null;
      socketExc = false;

      final response = await http.get(
        Uri.parse('$videourl/api/videos'),
        headers: {
          'Content-Type': 'application/json',
          'x-apikey-header': 'api-access-key-5544'
        },
      );
      if (response.statusCode == 200) {
        final parseJson = json.decode(response.body);
        videosModel = VideosModel.fromJson(parseJson);

        isError = false;
        errorMessage = null;
      } else {
        errorMessage = json.decode(response.body)['message'];
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
    } finally {
      isLoading = false;
    }

    update();
  }

  Future<void> fetchVideo(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$videourl/api/videos/$id/'),
        headers: {
          'Content-Type': 'application/json',
          'x-apikey-header': 'api-access-key-5544'
        },
      );
      if (response.statusCode == 200) {
        final parseJson = json.decode(response.body);
        videoDetailModel = VideoDetailModel.fromJson(parseJson);

        isError = false;
        errorMessage = null;
      } else {
        errorMessage = json.decode(response.body)['message'];
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
