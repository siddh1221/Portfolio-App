import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/colors/app_color.dart';
import '../../widget/text_form_field.dart';
import '../home_page/home_page.dart';

class AddBio extends StatefulWidget {
  const AddBio({
    super.key,
  });

  @override
  State<AddBio> createState() => _AddBioState();
}

class _AddBioState extends State<AddBio> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController shortDetailController = TextEditingController();
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  addData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstAdd', true);
    prefs.setString('name', nameController.text);
    prefs.setString('email', emailController.text);
    prefs.setString('shortDescription', shortDetailController.text);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Bio"),
          centerTitle: true,
        ),
        backgroundColor: AppColor.scaffoldColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 20.h,
              ),
              MyTextFormField(
                label: "Name",
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              MyTextFormField(
                  label: "Email",
                  controller: emailController,
                  validator: (value) => validateEmail(value)),
              SizedBox(
                height: 20.h,
              ),
              MyTextFormField(
                label: "Short Description",
                controller: shortDetailController,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Description';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addData();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false);
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: AppColor.black),
                    )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
