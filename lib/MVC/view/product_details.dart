// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/app_icon.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import '../controller/db_conrtoller.dart';
import '../controller/product_det_controller.dart';
import '../models/prodect_model.dart';



class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductController>(
          builder: (context, controller, child) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(controller!.productsCart[0].image!,),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 15,
                        right: 15,
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            AppIcon(
                              Icons.favorite_border,
                              backgroundColor: Colors.white,
                              iconColor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        BigText(
                          text: controller!.productsCart[0].name!,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        BigText(text: 'Details'),
                        const SizedBox(
                          height: 20,
                        ),
                        SmallText(
                          text:controller!.productsCart[0].description!,
                          color: Colors.black87,
                          fontSize: 16,
                          hight: 1.5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),


      bottomNavigationBar: Consumer<ProductController>(
        builder: (context, controller, child) {
          return
      Container(
        height: MediaQuery.of(context).size.height * 0.0908,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallText(
                  text: 'PRICE',
                  fontSize: 14,
                ),
                BigText(
                  text: '\$${controller!.productsCart[0].price!}',
                  color: Colors.green,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                elevation: 0,
                onPrimary: Colors.green,
                minimumSize: Size(MediaQuery.of(context).size.width * 0.4,
                    MediaQuery.of(context).size.height * 0.06),
              ),
              onPressed: ()async{
                ProductModel Product = ProductModel(
                  id: controller.productsCart[0].id!,
                  name: controller.productsCart[0].name!,
                  price: controller.productsCart[0].price!,
                  image: controller.productsCart[0].image!,
                  description: controller.productsCart[0].description!,
                  category: controller.productsCart[0].category!,
                );
               // context.read<DbController>().insertNewStudent(Product);
               print(Product.id);
               // log(Product.toMap());
                await controller.addProductToCart(Product);
                 controller.productsCart.clear();
              },
              child: const Center(
                  child:  Text(
                    'ADD',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )),
            )
          ],
        ),
      );
        }
      ),
    );
  }
}
