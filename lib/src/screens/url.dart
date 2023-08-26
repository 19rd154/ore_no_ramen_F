import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherExample extends StatelessWidget {
  UrlLauncherExample({Key? key}) : super(key: key);

  final _urlLaunchWithStringButton = UrlLaunchWithStringButton();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
          child: const Text("powerd by ホットペッパー webサービス"),
          onPressed: () {
            _urlLaunchWithStringButton.launchUriWithString(
              context,
              "http://webservice.recruit.co.jp/",
            );
          }),
        );
  }
}

class UrlLaunchWithStringButton {
  final alertSnackBar = SnackBar(
    content: const Text('このURLは開けませんでした'),
    action: SnackBarAction(
      label: '戻る',
      onPressed: () {},
    ),
  );

  Future launchUriWithString(BuildContext context, String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      alertSnackBar;
      ScaffoldMessenger.of(context).showSnackBar(alertSnackBar);
    }
  }
}