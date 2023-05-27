import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../utils/helper.dart';
import '../controller/profile_controller.dart';



class ProfilePage extends StatelessWidget with Helpers{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileController>().context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الصفحة الشخصية',
          style: GoogleFonts.aBeeZee(color: Colors.white),
        ),

        backgroundColor: Colors.green.shade400,
        centerTitle: true,
        leading: Switch(
          value: context.watch<ProfileController>().isDark,
          onChanged: (value) {
            context.read<ProfileController>().changeTheme();
          },
          activeColor: Colors.green.shade400,
          activeTrackColor: Colors.grey,
          inactiveThumbColor: Colors.green.shade400,
          inactiveTrackColor: Colors.grey,
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
        future: context.read<ProfileController>().getProfileData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||  snapshot.connectionState == ConnectionState.none)  {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: context.read<ProfileController>().pickedFile == null
                            ?Image.network(
                          "snapshot.data!['image']",
                          fit: BoxFit.cover,
                        )
                            : Image.file(
                          File(context.read<ProfileController>().pickedFile!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: IconButton(
                          onPressed: () async{
                            //  bool y = await controller.isIm(widget.idUser!);
                            await context.read<ProfileController>().pickImage();
                            final connectivityResult = await (Connectivity().checkConnectivity());
                            if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                              context.read<ProfileController>().uoloadImage();
                            } else {
                              showSnackBar(context: context, content: 'No internet connection', error: true);
                            }
                          },
                          icon: const Icon(Icons.camera_alt),
                          style: IconButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black.withOpacity(0.3),
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  snapshot.data!['name'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(
                    Icons.email,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: Text(
                    ':  ${snapshot.data!['email']}',
                    style: GoogleFonts.aBeeZee(fontSize: 17),
                  ),
                ),


              ],
            );
          }
        },

      ),
    );
  }
}
