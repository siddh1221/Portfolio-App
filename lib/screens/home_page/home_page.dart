import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protfolio_app/screens/change_image_bio_pages/change_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/colors/app_color.dart';
import '../../widget/bio_info_list_tile.dart';
import '../change_image_bio_pages/change_image_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  String? email;
  String? imgPath;
  String? shortDetail;

  get() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    email = prefs.getString('email');
    shortDetail = prefs.getString('shortDescription');
    imgPath = prefs.getString('path');
    setState(() {});
  }

  @override
  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Do you want to Exit the App?',
                textAlign: TextAlign.center,
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: AppColor.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: AppColor.black),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColor.scaffoldColor,
                  ),
                  child: Center(
                    child: SizedBox(
                        height: 150.h,
                        width: 150.w,
                        child: imgPath != null
                            ? Image.file(File(imgPath!))
                            : Image.asset(
                                'asset/p.jpg',
                                fit: BoxFit.cover,
                              )),
                  )),
              ListTile(
                leading: const Icon(
                  Icons.image,
                  color: AppColor.black,
                ),
                title: const Text('Change Image'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SaveImageLocallyView(),
                      ));
                },
              ),
            ],
          ),
        ),
        backgroundColor: AppColor.scaffoldColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangeDetail(),
                ));
          },
          child: const Icon(Icons.edit),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Bio",
            style: TextStyle(fontSize: 30.sp),
          ),
        ),
        body: Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                        height: 150.h,
                        width: 200.w,
                        child: imgPath != null
                            ? Image.file(File(imgPath!))
                            : Image.asset(
                                'asset/p.jpg',
                                fit: BoxFit.cover,
                              )),
                  ),
                  BioInfoListTile(
                    label: 'Name',
                    detail: name ?? "",
                  ),
                  BioInfoListTile(
                    label: 'Email',
                    detail: email ?? "",
                  ),
                  BioInfoListTile(
                    label: 'Description',
                    detail: shortDetail ?? "",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
