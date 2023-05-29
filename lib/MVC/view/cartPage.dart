import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import '../controller/db_conrtoller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Consumer<DbController>(
      builder: (context, controller, x) {
        controller.Product.isEmpty ? log('empty') : log('not empty');
        return controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(

                children: [
                  Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.07,
                          left: 20,
                          right: 5),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: controller.Product.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Container(
                              width: 340,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    controller.Product[index].image!,
                                    height: 150,
                                    width: 120,
                                    fit: BoxFit.fill,
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.Product[index].name!,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '\$ ${controller.Product[index].price!}',
                                        style: const TextStyle(
                                            color: Colors.green, fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),

                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                         controller.deleteStudent(controller.Product[index].id!);
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            )
                          ]);
                        },
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: controller.total > 0
                        ? Container(
                      width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.098,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
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
                                      text: 'TOTAL',
                                      fontSize: 14,
                                    ),
                                    BigText(
                                      text: '\$ ${controller.total}',
                                      color: Colors.green,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF00C569),
                                    elevation: 0,
                                    onPrimary: Colors.green,
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width *
                                            0.33,
                                        MediaQuery.of(context).size.height *
                                            0.01),
                                  ),
                                  onPressed: () {},
                                  child: const Center(
                                      child: Text(
                                    'CHECKOUT',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  )
                ],
              );
      },
    );

  }
}
