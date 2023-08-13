# world

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# ore_no_ramen_F

imagepickerについて、iosに対しては、

バージョン0.8.1以降、iOS 実装では PHPicker を使用して iOS 14 以降で (複数の) 画像を選択します。PHPicker を実装した結果、iOS 14 以降の iOS シミュレーターで HEIC イメージを選択できなくなります。これは既知の問題です。Apple がこの問題を解決するまで、実際のデバイスでこれをテストするか、非 HEIC イメージでテストしてください。 63426347 - Apple の既知の問題

にある Info.plistファイルに次のキーを追加します<project root>/ios/Runner/Info.plist。

NSPhotoLibraryUsageDescription- アプリに写真ライブラリの許可が必要な理由を説明します。これは、ビジュアル エディターでは [プライバシー - フォト ライブラリの使用説明]と呼ばれます。
false常にを 渡す場合、この権限は要求されませんrequestFullMetadataが、App Store ポリシーでは plist エントリを含めることが必要です。
NSCameraUsageDescription- アプリがカメラにアクセスする必要がある理由を説明します。これは、ビジュアル エディターでは「プライバシー - カメラ使用の説明」と呼ばれます。
NSMicrophoneUsageDescription- ビデオを録画する場合、アプリがマイクにアクセスする必要がある理由を説明します。これは、 ビジュアル エディターでは[プライバシー - マイク使用の説明]と呼ばれます。

だそうです。
