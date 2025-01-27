import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanning_effect/scanning_effect.dart';
import 'package:thali/screens/report_screen.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  bool isCaptured = false;
  File? imageFile;

  void captureImage() async {
    // Add your capture logic here

    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (image != null) {
        imageFile = File(image.path);
        isCaptured = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // background image

          (isCaptured)
              ? Image.file(
                  imageFile!,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit
                      .cover, // Ensure the image fills the available space
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Color(0xff4562df),
                  ), // Placeholder for camera preview
                ),

          (isCaptured)
              ? Positioned(
                  top: 40,
                  left: 90,
                  child: Text(
                    'Scanning...',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              : Positioned(
                  top: 40,
                  left: 90,
                  child: Text(
                    'Capture the Image \nto Start Scanning...',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

          const Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 300,
              width: 300,
              child: ScanningEffect(
                scanningColor: Colors.white,
                borderLineColor: Colors.white,
                delay: Duration(seconds: 1),
                duration: Duration(seconds: 2),
                child: SizedBox(),
              ),
            ),
          ),
          if (isCaptured)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 110,
                  padding: const EdgeInsets.only(
                    left: 25,
                    top: 20,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Label',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ReportScreen(
                                      imageFile: imageFile,
                                    )));
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(0xff4562df),
                            radius: 30,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          if (!isCaptured)
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  captureImage();
                },
                child: Container(
                  height: 80,
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  margin: EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Capture',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                          color: Colors.black54,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xff4562df),
                        radius: 30,
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
