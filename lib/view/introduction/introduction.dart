import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../utils/ui/theme/widgets/tm_text.dart';
import '../../view_model/introduction/introduction.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    var pageDecoration = PageDecoration(
      titleTextStyle: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).backgroundColor,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Theme.of(context).backgroundColor,
            pages: [
              PageViewModel(
                titleWidget: Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: const TMText("Analyze images", fontWeight: FontWeight.bold, fontSize: 24),
                ),
                bodyWidget: const TMText("Analyze activities, events, people, etc. in images stored on your device.", fontWeight: FontWeight.w400, fontSize: 16, height: 1.4),
                image: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Lottie.asset("assets/animations/json/big_data.json"),
                ),
                decoration: pageDecoration,

              ),
              PageViewModel(
                titleWidget: Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: const TMText("Images by location", fontWeight: FontWeight.bold, fontSize: 24),
                ),
                bodyWidget: const TMText("See the photos you took on the map or select the image and see the location of the image on the map.", fontWeight: FontWeight.w400, fontSize: 16, height: 1.4),
                image: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Lottie.asset("assets/animations/json/location_in_images.json"),
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                  titleWidget: Padding(
                    padding: EdgeInsets.only(top: 0.h),
                    child: const TMText("We need some permissions", fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  bodyWidget: const TMText("1- Access to your gallery to process them on your phone (completely safe)\n2- Draw over other apps", fontWeight: FontWeight.w400, fontSize: 16, height: 1.4),
                  image: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Lottie.asset("assets/animations/json/files.json"),
                  ),
                  decoration: pageDecoration,
                  footer: ElevatedButton(
                    onPressed: () async {
                      context.read<OnBoardingViewModel>().requestStoragePermission(context);
                    },
                    child: const Text("Grant permission"),
                  )

              ),
            ],
            onDone: () => context.read<OnBoardingViewModel>().requestStoragePermission(context),
            onSkip: () => context.read<OnBoardingViewModel>().requestStoragePermission(context), // You can override onSkip callback
            showSkipButton: true,
            dotsFlex: 2,
            skipOrBackFlex: 1,
            nextFlex: 1,
            showBackButton: false,
            //rtl: true, // Display as right-to-left
            back: const Icon(Icons.arrow_back),
            skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
            next: const Icon(Icons.arrow_forward),
            done: const Icon(Icons.check),
            curve: Curves.fastLinearToSlowEaseIn,
            // controlsMargin: const EdgeInsets.all(16),
            controlsPadding: kIsWeb
                ? const EdgeInsets.all(12.0)
                : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                color: Color(0xFFBDBDBD),
                activeSize: Size(22.0, 10.0),
                activeColor: Colors.green,
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                )
            )
        )
    );
  }
}
