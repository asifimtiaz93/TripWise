import 'package:flutter/material.dart';
import 'package:tripwise/widgets/app_large_text.dart';
import 'package:tripwise/widgets/app_text.dart';
import 'package:tripwise/widgets/responsive_button.dart';

import '../misc/colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "1.jpg",
    "2.jpg",
    "3.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/${images[index]}"),
                    fit: BoxFit.cover),
              ),
              child: Container(
                  margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, //!this aligns the text from the beginning
                        children: [
                          AppLargeText(
                            text: "Trips",
                          ),
                          AppText(
                            text: "Mountain",
                            size: 30,
                          ),
                          Container(
                            width: 250,
                            child: AppText(
                                text:
                                    "Mountain hike are beautiful thing. we must do it every once in a blue moon.",
                                 color: AppColors.textColor1,
                                ),
                          ),
                          SizedBox(height: 40,),
                          ResponsiveButton(width: 120,text: 'Next',),
                        ],
                      )
                    ],
                  )),
            );
          }),
    );
  }
}
