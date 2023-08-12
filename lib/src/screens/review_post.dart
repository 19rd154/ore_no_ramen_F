import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class ReviewSend extends StatefulWidget {
  const ReviewSend({Key? key}) : super(key: key);

  @override
  _ReviewSendState createState() => _ReviewSendState();
}

class _ReviewSendState extends State<ReviewSend> {
  String _text = '';
  File? _image;
  final picker = ImagePicker();


  Future _getImage() async {
    //カメラロールから読み取る
    //final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('画像が選択できませんでした。');
      }
    });
  }


 void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }
 
 void _saveText() {
    // テキストを変数に保存する処理
    print('テキストが保存されました: $_text');
  }

 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  '画像を選択',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Center(
                  child: _image == null
                      ? const Text('画像が選択されていません')
                      : Image.file(_image!),
                ),
                Center(
                  child: TextButton(
                    onPressed: _getImage,
                    child: Text('画像を選択する'),
                  ),
                )
              ],
            ),
          ),
          Container(
                padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    
                  ),
                  child: TextFormField(
                      enabled: true,
                      onChanged: _handleText,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Review',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2))),
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                ),
                ElevatedButton(
                  onPressed: _saveText, // 新しく追加したボタンのコールバック
                  child: Text('テキストを保存'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

