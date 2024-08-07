import 'package:flutter/material.dart';
import 'package:pacola_quiz/core/common/widgets/image_gradient_background.dart';
import 'package:pacola_quiz/core/resources/media_resources.dart';
import 'package:pacola_quiz/src/quick_access/presentation/refactors/quick_access_app_bar.dart';
import 'package:pacola_quiz/src/quick_access/presentation/refactors/quick_access_header.dart';
import 'package:pacola_quiz/src/quick_access/presentation/refactors/quick_access_tab_bar.dart';
import 'package:pacola_quiz/src/quick_access/presentation/refactors/quick_access_tab_body.dart';

class QuickAccessView extends StatelessWidget {
  const QuickAccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: QuickAccessAppBar(),
      body: ImageGradientBackground(
        image: MediaRes.documentsGradientBackground,
        child: Center(
          child: Column(
            children: [
              Expanded(flex: 2, child: QuickAccessHeader()),
              Expanded(child: QuickAccessTabBar()),
              Expanded(flex: 2, child: QuickAccessTabBody()),
            ],
          ),
        ),
      ),
    );
  }
}
