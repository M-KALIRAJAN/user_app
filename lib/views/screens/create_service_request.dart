import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/widgets/app_back.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';

import 'dart:async';

class CreateServiceRequest extends StatefulWidget {
  const CreateServiceRequest({super.key});

  @override
  State<CreateServiceRequest> createState() => _CreateServiceRequestState();
}

class _CreateServiceRequestState extends State<CreateServiceRequest> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];

  final AudioRecorder _audioRecorder = AudioRecorder();

  bool isRecording = false;
  String? recordedFilePath;
  final AudioPlayer _audioPlayer = AudioPlayer();

  final TextEditingController descriptionController = TextEditingController();

  bool isPlaying = false;

  @override
  void dispose() {
    descriptionController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<bool> requestMicPermission() async {
    try {
      final status = await Permission.microphone.status;

      if (status.isGranted) {
        return true;
      }

      final result = await Permission.microphone.request();
      return result.isGranted;
    } catch (e) {
      debugPrint("Permission error: $e");
      return false;
    }
  }

  Future<void> startRecording() async {
    final hasPermission = await requestMicPermission();

    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Microphone permission required")),
      );
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    final path =
        '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _audioRecorder.start(
      RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: path,
    );

    setState(() {
      isRecording = true;
      recordedFilePath = path;
    });
  }

  Future<void> stopRecording() async {
    final path = await _audioRecorder.stop();

    setState(() {
      isRecording = false;
      recordedFilePath = path;
    });
  }

  Future<void> playPauseVoice() async {
    if (recordedFilePath == null) return;

    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(recordedFilePath!));
    }

    setState(() => isPlaying = !isPlaying);
  }

  Future<void> VoiceRecord() async {
    if (isRecording) {
      await stopRecording();
    } else {
      await startRecording();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImages.add(image);
      });
    }
  }

  Future<void> SendRequest() async {
    //Print description
    debugPrint("Description:");
    debugPrint(descriptionController.text);

    // Print selected images paths
    debugPrint("Selected Images:");
    for (var image in selectedImages) {
      debugPrint(image.path);
    }

    // Print recorded audio path
    debugPrint("Recorded Audio:");
    if (recordedFilePath != null) {
      debugPrint(recordedFilePath!);
    } else {
      debugPrint("No audio recorded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_clr,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 17,
                right: 17,
                top: 10,
                bottom: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCircleIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  Text(
                    "Create Servie Request",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Text(""),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Servie category",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Select Services*",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                          DropdownMenuItem(
                            value: "Female",
                            child: Text("Female"),
                          ),
                          DropdownMenuItem(
                            value: "Other",
                            child: Text("Other"),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 18),
                      Text(
                        "Issuse Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Select Services*",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: const [
                          DropdownMenuItem(value: "Male", child: Text("Male")),
                          DropdownMenuItem(
                            value: "Female",
                            child: Text("Female"),
                          ),
                          DropdownMenuItem(
                            value: "Other",
                            child: Text("Other"),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: descriptionController,
                        minLines: 5,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: "Describe your issue…",
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.all(14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),

                      SizedBox(height: 18),
                      Text(
                        "Media Upload (optional)",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15),

                      SizedBox(
                        height: 90,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedImages.length + 1,
                          separatorBuilder: (_, __) => SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            // ADD MEDIA BUTTON
                            if (index == selectedImages.length) {
                              return InkWell(
                                onTap: () {
                                  pickImage(ImageSource.camera); // or gallery
                                },
                                child: Container(
                                  width: 88,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      76,
                                      149,
                                      129,
                                      1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Add Media",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(selectedImages[index].path),
                                    width: 88,
                                    height: 88,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImages.removeAt(index);
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned.fill(
                                  child: Center(
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white.withOpacity(0.8),
                                      size: 26,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 15),
                      Container(
                        height: 49,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromRGBO(76, 149, 129, 100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: VoiceRecord,
                            child: Container(
                              height: 49,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isRecording
                                    ? const Color.fromARGB(255, 8, 101, 42)
                                    : Color.fromRGBO(76, 149, 129, 1),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isRecording ? Icons.stop : Icons.mic,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    isRecording
                                        ? "Recording... "
                                        : "Record Voice",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (isRecording)
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      if (recordedFilePath != null && !isRecording) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                ),
                                onPressed: playPauseVoice,
                              ),
                              const Text("Recorded Voice"),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    recordedFilePath = null;
                                    isPlaying = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        AppButton(
                          text: "Send Request",
                          onPressed: () {
                            SendRequest();
                          },
                          color: AppColors.btn_primery,
                          width: double.infinity,
                        ),
                        SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
