import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/merge_video_controller.dart';
import 'package:video_player/video_player.dart';
import 'dart:io'; // Although not directly used for UI, useful if debugging file paths

class MergeVideoView extends GetView<MergeVideoController> {
  const MergeVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put ensures the controller is initialized and available
    Get.put(MergeVideoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Merge Two Videos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: controller.pickVideo,
                  child: const Text("Pick Video from Gallery"),
                ),
                const SizedBox(height: 12),

                Text(
                  "Selected Videos:",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),

                // Display selected videos with a delete option
                if (controller.selectedVideos.isEmpty)
                  const Text('No videos selected yet.')
                else
                  ...controller.selectedVideos.asMap().entries.map(
                        (entry) {
                          final int index = entry.key;
                          final String videoPath = entry.value;
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: Text(
                                videoPath.split('/').last,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(videoPath), // Show full path for debugging
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  controller.selectedVideos.removeAt(index);
                                  // Clear merged video if selected videos change after a merge
                                  if (controller.mergedVideoPath.isNotEmpty) {
                                    controller.clearSelectedVideos();
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: controller.selectedVideos.length == 2 && !controller.isMerging.value
                      ? controller.mergeVideos
                      : null, // Button is disabled if not exactly 2 videos or if merging
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: controller.isMerging.value
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          "Merge Videos",
                          style: TextStyle(fontSize: 18),
                        ),
                ),

                const SizedBox(height: 16),

                // Display merge status
                Text(
                  controller.mergeStatus.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blueGrey),
                ),

                const SizedBox(height: 16),

                // Display merged video path and player
                if (controller.mergedVideoPath.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Merged Video Path:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        controller.mergedVideoPath.value,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 16),
                      // Video Player
                      if (controller.videoController != null &&
                          controller.videoController!.value.isInitialized)
                        AspectRatio(
                          aspectRatio: controller.videoController!.value.aspectRatio,
                          child: VideoPlayer(controller.videoController!),
                        )
                      else if (controller.mergedVideoPath.isNotEmpty && !controller.isMerging.value)
                        const Center(
                          child: CircularProgressIndicator(), // Show loading for player if path exists but not initialized
                        ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: controller.clearSelectedVideos,
                        icon: const Icon(Icons.refresh),
                        label: const Text("Clear & Start Over"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}