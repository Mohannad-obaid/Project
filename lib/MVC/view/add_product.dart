// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/helper.dart';
import '../../widget/textFiled.dart';
import '../controller/add_product_controller.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> with Helpers {


  @override
  Widget build(BuildContext context) {
    return
      Consumer<APController>(
        builder:(context,controller,x)
        => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const SizedBox(
                    height: 30,
                  ),
                    TextFiledWidget(
                      controller: controller.nameController,
                      hintText: 'Name',
                      valedtor: '',
                      onChang: (String ) {
                        controller.nameController.text = String;

                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFiledWidget(
                      controller: controller.descriptionController,
                      hintText: 'Description',
                      valedtor: '',
                      onChang: (String ) {
                        controller.descriptionController.text = String;

                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFiledWidget(
                      controller: controller.priceController,
                      hintText: 'Price',
                      valedtor: '',
                      onChang: (String ) {
                        controller.priceController.text = String;

                      },
                       keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                controller.pickedFile != null
                    ? Image.file(
                  File(controller.pickedFile!.path),
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await controller.pickImage();
                        },
                        child: Icon(Icons.image),
                      ),


                      const Text('Category: '),
                      Center(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            List<DropdownMenuItem<String>> items = snapshot
                                .data!.docs
                                .map((document) =>
                                DropdownMenuItem<String>(
                                  value: document.id,
                                  child: Text(document['name']),
                                ))
                                .toList();

                            return DropdownButton<String>(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 16,
                              //  isExpanded: true,
                              hint: const Text('Select Category'),
                              value:controller.selectedItem,
                              onChanged: (String? newValue) {
                                setState(() {
                                  controller.selectedItem = newValue!;
                                  controller.categoryController.text = newValue!;

                                });
                              },
                              items: items,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.context = context;
                      if (controller.nameController.text.isNotEmpty && controller.categoryController.text.isNotEmpty && controller.descriptionController.text.isNotEmpty && controller.priceController.text.isNotEmpty ) {
                        controller.uoloadImage();
                      } else {
                        showSnackBar(context: context, content: 'الرجاء التاكد من ادخال المعلومات كاملة', error: true);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );


  }




}
