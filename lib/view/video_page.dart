import 'package:dummyjson/controller/videopage_controller.dart';
import 'package:dummyjson/view/widgets/videoplayer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(VideoPageController());
    return GetBuilder<VideoPageController>(builder: (_) {
      if (_.isLoading) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (_.isError) {
        return Center(child: Text(_.errorMessage ?? "Something went wrong"));
      } else {
        return Scaffold(
            body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _.videosModel!.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final video = _.videosModel?.data![index];
                  return ListTile(
                    onTap: () async {
                      await _.fetchVideo(video.id!);
                      if (_.videoDetailModel != null) {
                        Get.to(() => VideoplayerPage(
                            url: _.videoDetailModel!.data!.videoUrl!));
                      } else {
                        Get.snackbar("Error", "Failed to load video details");
                      }
                    },
                    title: Text(video!.title ?? 'No title'),
                    subtitle: Text(
                      video.createdAt != null
                          ? 'Created on: ${DateFormat.yMMMd().format(video.createdAt!)}'
                          : 'Creation date unavailable',
                    ),
                  );
                },
              ),
            ),
          ],
        ));
      }
    });
  }
}
