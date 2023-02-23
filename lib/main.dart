import 'dart:developer';
import 'dart:html';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_indicator/carousel_indicator.dart';

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
  PageController pageController = PageController(
    viewportFraction: 0.8,
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: items.asMap().entries.map((entry) {
              //     return GestureDetector(
              //       onTap: () => _controller.animateToPage(entry.key),
              //       child: Container(
              //         width: 12.0,
              //         height: 12.0,
              //         margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: (Theme.of(context).brightness == Brightness.dark
              //                 ? Colors.white
              //                 : Colors.deepOrange)
              //                 .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              //       ),
              //     );
              //   }).toList(),
              // ),

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

              SizedBox(
                  height: 200,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: imageCategories.length,
                      itemBuilder: (_, index) {
                        return Categoty(
                          image : imageCategories[index],
                          number : numbersCategories[index],
                          title : titleCategories[index],
                        );
                      })
              ),

               SizedBox(
                 height: 250,
                 child: ListView.builder(
                   physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: imageCategories.length, itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Card(
                      color: Colors.blue,
                      child: Container(
                        child: Center(child: Text(imageCategories[index].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
                      ),
                    ),
                  );
              }),
               ),


              const SizedBox(
                height: 500,
                child:Text('l')
              ),
              // 'assets/images/image.png'
              // Text('jjjjjjj'),
            ],
          ),
        ),
        //NavigationBar
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
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
                label: "Profile",
                icon: Icon(Icons.account_circle),
              ),
            ],
            onTap: (int indexOfItem) {}),
      ),
    );
  }
}

class Categoty extends StatelessWidget {

  final String? image;
  final String? title;
  final String? number;

  const Categoty({super.key,  required this.image, required this.title, required this.number});

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
