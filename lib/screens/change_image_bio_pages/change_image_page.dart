import 'package:flutter/material.dart';
import 'package:protfolio_app/screens/home_page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../core/colors/app_color.dart';

/// save image on cache using shared_preferences throw image's path

File? imgFile;
String? imgPath;

class SaveImageLocallyView extends StatefulWidget {
  const SaveImageLocallyView({Key? key}) : super(key: key);

  @override
  State<SaveImageLocallyView> createState() => _SaveImageLocallyViewState();
}

class _SaveImageLocallyViewState extends State<SaveImageLocallyView> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: AppBar(
        title: const Text("Change Image"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // image

            if (imgPath != null)
              Expanded(
                child: Image.file(File(imgPath!)),
              ),
            if (imgPath == null) Expanded(child: Image.asset('asset/p.jpg')),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(AppColor.white)),
                onPressed: () async {
                  getImg();
                },
                child: const Text(
                  "Change Image",
                  style: TextStyle(color: AppColor.black),
                )),
          ],
        ),
      ),
    );
  }

  // get image from gallery
  void getImg() async {
    final pickedImage =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      saveData(pickedImage.path.toString()); // path cache
      setState(() {
        imgFile = File(pickedImage.path);
      });
    }
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false);
  }

  void saveData(String val) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString('path', val);
    getData();
  }

  void getData() async {
    final sharedPref = await SharedPreferences.getInstance();
    setState(() {
      imgPath = sharedPref.getString('path');
    });
  }

  void deleteData() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove('path');
    getData();
  }
}
