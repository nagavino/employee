import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

//ignore: must_be_immutable
class LottieAnimationWidget extends StatefulWidget {
  String jsonData;
  double? height;
  double? width;
  dynamic alignment;
  dynamic boxFit;
  LottieAnimationWidget(
      {super.key,
      this.boxFit,
      this.width,
      this.height,
      this.alignment,
      required this.jsonData});

  @override
  State<LottieAnimationWidget> createState() => _LottieAnimationWidgetState();
}

class _LottieAnimationWidgetState extends State<LottieAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int cont = 0;
  int targetCount = 1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        cont++;
        if (cont < 1) {
          _controller.reset();
          _controller.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.jsonData,
      alignment: widget.alignment,
      repeat: false,
      fit: widget.boxFit,
      height: widget.height,
      width: widget.width,
      controller: _controller,
      animate: true,
      onLoaded: (composition) {
        _controller.duration = composition.duration;
        _controller.forward();
      },
    );
  }
}
