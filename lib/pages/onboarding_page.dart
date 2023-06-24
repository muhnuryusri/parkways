import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:parkways/color_constants.dart';
import 'package:parkways/widgets/custom_button.dart';
import 'package:parkways/widgets/custom_outlined_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: IntroductionScreen(
                pages: [
                  PageViewModel(
                    title: 'Solusi parkir & valet',
                    body:
                        'Optimalkan potensi penambahan pendapatan titik parkir anda.',
                    image: buildImage('assets/onboarding_image_1.png'),
                    decoration: getPageDecoration(),
                  ),
                  PageViewModel(
                    title: 'Mobilitas tinggi',
                    body:
                        'Proses transaksi semi digital, device dan aplikasi mudah dibawa kemana saja sehingga mengefisienkan waktu',
                    image: buildImage('assets/onboarding_image_2.png'),
                    decoration: getPageDecoration(),
                  ),
                  PageViewModel(
                    title: 'Transparansi laporan',
                    body:
                        'Peningkatan standar pengelolaan dan transparansi laporan kegiatan operasional di lapangan.',
                    image: buildImage('assets/onboarding_image_3.png'),
                    decoration: getPageDecoration(),
                  ),
                ],
                showDoneButton: false,
                showNextButton: false,
                dotsDecorator: getDotDecoration(),
                nextFlex: 1,
                globalFooter: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          color: ColorConstants.mainColor,
                          text: 'Parking',
                          onPressed: () {
                            Navigator.pushNamed(context, 'login_page');
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomOutlinedButton(
                          text: 'Valet',
                          onPressed: () {
                            Navigator.pushNamed(context, 'login_page');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: ColorConstants.strokeColor,
        activeColor: ColorConstants.mainColor,
        size: const Size(10, 10),
        activeSize: const Size(10, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ColorConstants.primaryFontColor),
        bodyTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ColorConstants.secondaryFontColor,
        ),
        imageFlex: 2,
        contentMargin: const EdgeInsets.symmetric(horizontal: 65.0),
        pageColor: Colors.white,
      );
}
