
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/big_text.dart';
import '../../widget/small_text.dart';
import '../controller/db_conrtoller.dart';
import '../controller/home_controller.dart';
import '../controller/product_det_controller.dart';
import '../models/prodect_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Consumer2<HomeController,ProductController>(
        builder: (context, controller, controller2, child) {
        return
          Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.07,
              left: 20,
              right: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 25,
              ),
              BigText(
                text: 'Categories',
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
            height: 130,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
              const SizedBox(width: 10),
              itemCount: controller.Categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    ProductModel Product = ProductModel(
                      name: 'Product ${index + 1}',
                      image: 'https://imglarger.com/Images/before-after/ai-image-upscaler-2-after.jpg',
                      price: 100,
                      description: 'Product ${index + 1} description',

                    );
                     context.read<DbController>().insertNewStudent(Product);


                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 70,
                          width: 70,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                spreadRadius: 5,
                                offset: const Offset(
                                  0,
                                  0,
                                ),
                              ),
                            ],
                          ),
                          child:
                          Image.network(controller.Categories[index].image!,filterQuality: FilterQuality.high,)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        controller.Categories[index].name!,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BigText(
                    text: 'Best Selling',
                    fontSize: 18,
                  ),
                  SmallText(
                    text: 'See All',
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),

            Container(
            height: 305,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.products.length,
                itemBuilder: (context,index){
                  return InkWell(
                      onTap: () {
                        controller2.productsCart.add(controller.products[index]) ;
                        Navigator.pushNamed(context, '/productDetails');
                      },
                      child: Container(

                        height: 330,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                             controller.products[index].image!,
                              height: 240,
                              width: (MediaQuery.of(context).size.width-50)/2
                            ),
                            BigText(
                              text: controller.products[index].name!,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                            SmallText(
                              text: 'Bang & Olsen',
                              fontSize: 15,
                            ),
                            BigText(
                              text: '\$${controller.products[index].price}',
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),

                          ],
                        ),
                      ));
                },
                separatorBuilder: (context, index) =>
                const SizedBox(width: 10)),
          ),


            ],
          ),
        );
      });

  }
}
