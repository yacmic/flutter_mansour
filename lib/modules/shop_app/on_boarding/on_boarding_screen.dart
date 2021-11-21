import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/styles/colors.dart';
import 'package:udemy_flutter/shared/network/local/cash_helper.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(
    this.image,
    this.title,
    this.body,
  );
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        'assets/images/onBoard_1.jpg', 'On Board 1 Ttitle', 'On Board body 1'),
    BoardingModel(
        'assets/images/onBoard_1.jpg', 'On Board 2 Ttitle', 'On Board body 2'),
    BoardingModel(
        'assets/images/onBoard_1.jpg', 'On Board 3 Ttitle', 'On Board body 3'),
  ];

  var boardController = PageController();
  bool isLast = false;

  void submit() {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value!) navigateAndFinish(context, ShopLoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(
              text: 'Skip',
              function: submit,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  // physics for animation
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (val) {
                    if (val == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardController,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      spacing: 5,
                    ),
                    count: boarding.length,
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (!isLast) {
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      } else {
                        submit();
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Column buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
            //fit: BoxFit.cover,
          ),
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        SizedBox(height: 30.0),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        //PageView.builder(itemBuilder: (context, index) {}),
      ],
    );
  }
}
