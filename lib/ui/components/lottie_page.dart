import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePage extends StatelessWidget {
  final String lottieAsset;
  final String lottieText;

  LottiePage({@required this.lottieAsset, @required this.lottieText});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 400.0,
                  child: Lottie.asset(
                    '$lottieAsset',
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ),
              ),
              SizedBox(height: 4.0,),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    '$lottieText',
                    style: textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
