import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../constants/colors_data.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SpinKitFadingCircle(
        color: kPrimaryColor,
        size: 50.0,
      ),
    );
  }
}

class CustomBottomLoader extends StatelessWidget {
  final bool isLoading;
  final bool isNoMoreData;
  const CustomBottomLoader(
      {Key? key, this.isLoading = false, this.isNoMoreData = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isLoading ? 50 : 0,
      width: double.infinity,
      color: Colors.transparent,
      child: const Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor))),
    );
  }
}
