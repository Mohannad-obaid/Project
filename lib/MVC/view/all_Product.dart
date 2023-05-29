// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import '../controller/productWhereCategory.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Text(
          name,
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 13, right: 13),
        child: FutureBuilder(
            future:  FirebaseFirestore.instance.collection('products').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {

                return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 45,
                      // mainAxisSpacing: 150,
                      mainAxisExtent:
                      MediaQuery.of(context).size.height * 0.43,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          height: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                  snapshot.data!.docs[index]['image']
                                      .toString(),
                                  height: 240,
                                  width:
                                  (MediaQuery.of(context).size.width -
                                      50) /
                                      2),
                              BigText(
                                text: snapshot.data!.docs[index]['name']
                                    .toString(),
                                fontSize: 18,
                              ),
                              SmallText(
                                text: 'Bang & Olsen',
                                fontSize: 15,
                              ),
                              BigText(
                                text:
                                '\$${snapshot.data!.docs[index]['price']}',
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(child: Text('No data'));
              }
            }),
      ),
    );
  }
}
