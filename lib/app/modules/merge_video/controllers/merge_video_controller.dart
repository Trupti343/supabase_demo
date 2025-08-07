import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:easy_video_editor/easy_video_editor.dart'; 

class MergeVideoController extends GetxController {
  final selectedVideos = <String>[].obs;
  final isMerging = false.obs;
  final mergeStatus = ''.obs;
  final mergedVideoPath = ''.obs;

  VideoPlayerController? videoController;

  @override
  void onInit() {
    super.onInit();   
  }

  Future<void> pickVideo() async {
    
    if (selectedVideos.length >= 2) {
      Get.snackbar('Limit Reached', 'Only two videos can be selected for merging.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile != null) {
        selectedVideos.add(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error Picking Video', 'Could not pick video: $e',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      debugPrint('Error picking video: $e');
    }
  }

  // Merge videos using easy_video_editor
  Future<void> mergeVideos() async {
    if (selectedVideos.length != 2) {
      Get.snackbar('Error', 'Please select exactly two videos to merge.',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      return;
    }

    isMerging.value = true;
    mergeStatus.value = 'Merging videos... This might take a while.';

    try {
      final dir = await getTemporaryDirectory();
      // Define a unique output file name to avoid conflicts if merging multiple times
      final outputPath = '${dir.path}/merged_video_${DateTime.now().millisecondsSinceEpoch}.mp4';

      // Initialize the editor with the first video as the base
      final editor = VideoEditorBuilder(videoPath: selectedVideos[0])
          // Merge it with the second video.
          // The merge method here assumes the base video is combined with others provided in the list.
          .merge(otherVideoPaths: [selectedVideos[1]]);

      // Export the final merged video
      final finalMergedPath = await editor.export(outputPath: outputPath);

      if (finalMergedPath != null && finalMergedPath.isNotEmpty) {
        mergedVideoPath.value = finalMergedPath;
        mergeStatus.value = 'Videos merged successfully!';
        debugPrint('Merged video saved at: $finalMergedPath');

        await initializeVideo(finalMergedPath);
      } else {
        mergeStatus.value = 'Failed to merge videos: Output path is null or empty.';
        debugPrint('easy_video_editor export returned null or empty path.');
      }
    } catch (e) {
      mergeStatus.value = 'Failed to merge videos: $e';
      debugPrint('Merge Error: $e');
      Get.snackbar('Merge Failed', 'An error occurred during merging: $e',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
    } finally {
      isMerging.value = false;
    }
  }

  // Load merged video into player
  Future<void> initializeVideo(String path) async {
    // Dispose previous controller if any
    if (videoController != null) {
      await videoController!.dispose();
      videoController = null; // Set to null after disposing
    }

    videoController = VideoPlayerController.file(File(path));
    try {
      await videoController!.initialize();
      videoController!.setLooping(true); // Optional: loop the video
      videoController!.play();
      update(); // Manually trigger GetView rebuild for VideoPlayer display
    } catch (e) {
      Get.snackbar('Error Playing Video', 'Could not initialize video player: $e',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      debugPrint('Error initializing video player: $e');
      videoController = null; // Clear controller on error
      mergedVideoPath.value = ''; // Clear merged path on error
    }
  }

  void clearSelectedVideos() {
    selectedVideos.clear();
    mergedVideoPath.value = '';
    mergeStatus.value = '';
    if (videoController != null) {
      videoController!.dispose();
      videoController = null;
    }
    update(); // Manual update for cases where GetX observables might not trigger everything
  }

  @override
  void onClose() {
    videoController?.dispose(); // Dispose video controller when controller is closed
    super.onClose();
  }
}