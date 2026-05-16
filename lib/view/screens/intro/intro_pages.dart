import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mystarter/constants/colors_data.dart';
import 'package:mystarter/constants/images.dart';
import 'package:mystarter/constants/size_config.dart';
import '../home/home_screen.dart';
import 'components/intro_content.dart';

class IntroPages extends StatefulWidget {
  static const routeName = 'intro_screen';

  const IntroPages({Key? key}) : super(key: key);

  @override
  State<IntroPages> createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  final box = GetStorage();
  int currentPage = 0;
  List<Map<String, String>> splashData = [];
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    splashData = [
      {
        "text": "Order Your Goods",
        'decs':
            'Lorem ipsum dolor sit amet, consectetur elit,sed do eiusmod tempor incididunt.',
        "image": Get.isDarkMode ? Images.introDark1 : Images.intro1
      },
      {
        "text": "Pay Via Card",
        'decs':
            'Lorem ipsum dolor sit amet, consectetur elit,sed do eiusmod tempor incididunt.',
        "image": Get.isDarkMode ? Images.introDark2 : Images.intro2
      },
      {
        "text": "Quick Delivery",
        'decs':
            'Lorem ipsum dolor sit amet, consectetur elit,sed do eiusmod tempor incididunt.',
        "image": Get.isDarkMode ? Images.introDark3 : Images.intro3
      },
    ];
    return Scaffold(
      backgroundColor: Get.isDarkMode ? kBgDarkColor : kWhiteColor,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
              box.write('intro', true);
              Get.offAll(
                () => const HomeScreen(),
              );
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Skip',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontSize: 16, height: 1.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: splashData.length,
              itemBuilder: (context, index) => IntroContent(
                image: splashData[index]["image"],
                text: splashData[index]['text'],
                decs: splashData[index]['decs'],
                index: currentPage,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (currentPage != 0) {
                            controller.previousPage(
                                duration: const Duration(microseconds: 300),
                                curve: Curves.decelerate);
                          }
                        },
                        child: currentPage == 0
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Back',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(fontSize: 16, height: 1.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            splashData.length,
                            (index) => buildDot(index: index),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (currentPage != splashData.length - 1) {
                            controller.nextPage(
                                duration: const Duration(microseconds: 300),
                                curve: Curves.decelerate);
                          } else {
                            box.write('intro', true);
                            Get.offAll(
                              () => const HomeScreen(),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            currentPage == splashData.length - 1
                                ? 'Finish'
                                : 'Next',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(fontSize: 16, height: 1.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: currentPage == index ? 10 : 7,
      width: currentPage == index ? 10 : 7,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kBlackColor2,
        shape: BoxShape.circle,
      ),
    );
  }
}
