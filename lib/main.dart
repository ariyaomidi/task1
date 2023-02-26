import 'dart:core';
import 'dart:core';
import 'dart:developer';
import 'dart:html';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:task1/models/popular_deal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List items = [
    'assets/images/image.png',
    'assets/images/2.png',
    'assets/images/1.png',
    'assets/images/3.png',
    'assets/images/4.png',
  ];
  List imageCategories = [
    'assets/images/fruits.png',
    'assets/images/chicken.png',
    'assets/images/fish.png',
    'assets/images/fruits.png',
  ];
  List numbersCategories = [
    '1126',
    '142',
    '50',
    '98',
  ];

  List titleCategories = [
    'Fruits',
    'Chicken',
    'Fish',
    'Fruits',
  ];

 List<PopularDeal> popularList =[
  PopularDeal(
      pathImage:'assets/images/banana.png',
      off: '50' ,
      title: 'Banana' ,
      star: '4.5' ,
      ratings: '97',
      price: '15.00' ,),
 PopularDeal(
      pathImage:'assets/images/1.png',
      off: '4' ,
      title: 'test' ,
      star: '2.5' ,
      ratings: '50',
      price: '13.00' ,),
];

  PageController catogoriesController = PageController(
    viewportFraction: 0.3,
    initialPage: 1  );

  PageController popularController = PageController(
      viewportFraction: .9,
      initialPage: 0
  );

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //App Bar
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Hello,Brayden',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w800,
                          fontSize: 25),
                    ),
                    Text('Good Morning.',
                        style: TextStyle(color: Colors.black45, fontSize: 14)),
                  ],
                ),
                Row(
                  children: const [
                    badges.Badge(
                      badgeStyle: badges.BadgeStyle(badgeColor: Colors.orange),
                      badgeContent: Text('3'),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    CircleAvatar(
                        backgroundImage: AssetImage('assets/images/test.png')),
                  ],
                )
              ],
            ),
          ),
        ),
        //body
        body: SingleChildScrollView(
          child: Column(
            children: [

              //Searchbar
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(30),
                            prefixIcon: Icon(Icons.search_rounded),
                            hintText: 'Search...',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        final snackBar = SnackBar(
                          content: const Text('Sort'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.black45,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.sort_outlined,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Carousel Slider
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.width * 0.31,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
                items: items.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(image),
                                fit: BoxFit.fill,
                              )));
                    },
                  );
                }).toList(),
              ),

              //indicator
              CarouselIndicator(
                activeColor: Colors.orange,
                color: Colors.black12,
                height: 5,
                width: 30,
                count: items.length,
                index: _current,
              ),

              const SizedBox(
                width: 50,
              ),

              //Categories
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w800),
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Show all',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w800),
                              )),
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.deepOrange,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //List Categories
              SizedBox(
                  height: 200,
                  child: PageView.builder(
                      controller: catogoriesController,
                      itemCount: imageCategories.length,
                      itemBuilder: (_, index) {
                        return Categoty(
                          image : imageCategories[index],
                          number : numbersCategories[index],
                          title : titleCategories[index],
                        );
                      })
              ),

              //Popular Deals
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular Deals',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w800),
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Show all',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w800),
                              )),
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.deepOrange,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //List Popular Deals
              SizedBox(
                  height: 455,
                  child: PageView.builder(
                      controller: popularController,
                      itemCount: popularList.length,
                      itemBuilder: (_, index) {
                        return PopularItem(popularDeal: popularList[index]);
                      })
              ),

              //All Grocery
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                     SizedBox(
                      child:
                            Text(
                              'All Grocery',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),

              // list All Grocery
              SizedBox(
                width: 500,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250.0,
                      child: Stack(
                        children: [
                          Container(
                              width: 150.0,
                              height: 200.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/images/grocery1.jpg')))
                          ),
                          Positioned(
                            left: 25,
                            top:165,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.deepOrange,
                                  ),
                              margin: const EdgeInsets.all(20),
                              child:  const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '5% OFF',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400
                                  ),),
                              ),
                            ),
                          ),
                          const SizedBox(width: 130.0,),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: IconButton(onPressed: (){},
                              icon: const Icon(Icons.favorite,color: Colors.grey),),
                          )
                        ],
                      ),
                    ),


                    const SizedBox(
                      width: 15,
                    ),


                    //Dog Biscuit

                    const SizedBox(height: 20,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text(

                          'Dog Biscuit',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 20.0,),
                        Row(
                          children: [
                            Container(
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all( width: 1 ,color: Colors.grey),

                              ),
                              child: Row(

                                children:  const [
                                  Icon(Icons.star,color: Colors.orange,),
                                  Text(
                                    '4.5',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10.0,),
                            const Text(
                              '45 Ratings',
                              style:TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w100),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0,),
                        const Text(
                          '\$150.00',
                          style:TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0,),
                            Container(
                              width: 250,
                              height: 2,
                              decoration: BoxDecoration(

                                border: Border.all(
                                  width: 1 ,
                                  color: Colors.grey,

                                ),),),
                            const SizedBox(height: 10.0,),

                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/orange_percent.png',
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox( width: 20,),
                                const Text('5% off upto \$100',
                                  style:TextStyle(color: Colors.grey),),
                              ],
                            ),
                          ],
                        )

                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 500,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250.0,
                      child: Stack(
                        children: [
                          Container(
                              width: 150.0,
                              height: 200.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/images/grocery2.png')))
                          ),
                          Positioned(
                            left: 25,
                            top:165,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.deepOrange,
                              ),
                              margin: const EdgeInsets.all(20),
                              child:  const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '1% OFF',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400
                                  ),),
                              ),
                            ),
                          ),
                          const SizedBox(width: 130.0,),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: IconButton(onPressed: (){},
                              icon: const Icon(Icons.favorite,color: Colors.deepOrange),),
                          )
                        ],
                      ),
                    ),


                    const SizedBox(
                      width: 15,
                    ),


                    //Dog Biscuit


                    const SizedBox(height: 20,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text(

                          'Tomato',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 20.0,),
                        Row(
                          children: [
                            Container(
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all( width: 1 ,color: Colors.grey),

                              ),
                              child: Row(

                                children:  const [
                                  Icon(Icons.star,color: Colors.orange,),
                                  Text(
                                    '3.5',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10.0,),
                            const Text(
                              '20 Ratings',
                              style:TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w100),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0,),
                        const Text(
                          '\$10.00',
                          style:TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0,),
                            Container(
                              width: 250,
                              height: 2,
                              decoration: BoxDecoration(

                                border: Border.all(
                                  width: 1 ,
                                  color: Colors.grey,

                                ),),),
                            const SizedBox(height: 10.0,),

                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/orange_percent.png',
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox( width: 20,),
                                const Text('5% off upto \$100',
                                  style:TextStyle(color: Colors.grey),),
                              ],
                            ),
                          ],
                        )

                      ],
                    )
                  ],
                ),
              ),









              //test end widget
              const SizedBox(
                height: 1,
                child:Text('')
              ),
              // 'assets/images/image.png'
              // Text('jjjjjjj'),
            ],
          ),
        ),
        //NavigationBar

        bottomNavigationBar: BottomNavigationBar(
            currentIndex: 1,
            fixedColor: Colors.green,
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Search",
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.deepOrange,
                label: "Profile",
                icon: Icon(Icons.account_circle),
              ),
            ],
            onTap: (int indexOfItem) {}),

      ),
    );
  }
}



class PopularItem extends StatelessWidget {
  final PopularDeal popularDeal;

  const PopularItem({required this.popularDeal,super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    width: 500,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
                width: 350.0,
                height: 330.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            popularDeal.pathImage!)))
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  margin: const EdgeInsets.all(20),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${popularDeal.off}% OFF',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400
                      ),),
                  ),
                ),
                const SizedBox(width: 130.0,),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: IconButton(onPressed: (){},
                    icon: const Icon(Icons.favorite,color: Colors.grey),),
                )
              ],)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '${popularDeal.title}',
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4.0,),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all( width: 1 ,color: Colors.grey),

                  ),
                  child: Row(

                    children: [
                      const Icon(Icons.star,color: Colors.orange,),
                      Text(
                        '${popularDeal.star}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4.0,),
                Text(
                  '${popularDeal.ratings} Ratings',
                  style: const TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
            const SizedBox(width: 90.0,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '\$${popularDeal.price}',
                style:const  TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
            ),

          ],
        ),
      ],
    ),
    );
  }
}

class Categoty extends StatelessWidget {

  final String? image;
  final String? title;
  final String? number;

  const Categoty({
    super.key,
    required this.image,
    required this.title,
    required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
            width: 130.0,
            height: 130.0,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(12),
                image:  DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                        image!)))),
        const SizedBox(
          height: 10,
        ),
         Text(
          title!,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4.0,),
        Text(
          '$number Items',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
