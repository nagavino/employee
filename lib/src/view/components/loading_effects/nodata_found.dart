import 'package:flutter/material.dart';

import '../../../domain/constants.dart';
import '../../../domain/shared_preference/helper.dart';
import '../../animation/lottie_animation.dart';

class NoDataIllustration extends StatelessWidget {
  const NoDataIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Helper.responsiveScreenSize(
                    context,
                    type: 'width',
                    typeValue: 'no',
                    deviceSize: tabletXs,
                    success: Helper.mediaSize(context, 'width', 0.3),
                    /* tablet */
                    fail: Helper.mediaSize(context, 'width', 0.7), /* mobile */
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Helper.responsiveScreenSize(context,
                          type: 'width',
                          typeValue: 'no',
                          deviceSize: tabletXs,
                          success: Helper.mediaSize(context, 'width', 0.2),
                          /* tablet */
                          fail: Helper.mediaSize(context, 'width', 0.1)),
                      /* mobile */
                      right: Helper.responsiveScreenSize(context,
                          type: 'width',
                          typeValue: 'no',
                          deviceSize: tabletXs,
                          success: Helper.mediaSize(context, 'width', 0.2),
                          /* tablet */
                          fail: Helper.mediaSize(
                              context, 'width', 0.1)), /* mobile */
                    ),
                    child: LottieAnimationWidget(
                      jsonData:
                          'assets/img/json/no_data_found.json', // Path to your Lottie animation file.
                    ),
                  ),
                ),
                Text(
                  'No employee records found',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
