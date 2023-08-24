import 'package:flutter/material.dart';

class DropdownButtonMenu extends StatefulWidget {
  const DropdownButtonMenu({Key? key}) : super(key: key);

  @override
  State<DropdownButtonMenu> createState() => _DropdownButtonMenuState();
}

class _DropdownButtonMenuState extends State<DropdownButtonMenu> {
  String isSelectedValue = '/review';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: const[
        DropdownMenuItem(
            value: '/review',
            child: Text('更新順から検索'),
          ),
          DropdownMenuItem(
              value: '/review/bookmark',
              child: Text('お気に入りから検索'),
          ),
          DropdownMenuItem(
              value: '/review/evaluate',
              child: Text('評価順から検索'),
          ),
          DropdownMenuItem(
              value: '/review/period',
              child: Text('更新日から検索'),
          ),
          DropdownMenuItem(
              value: '/shop',
              child: Text('店舗から検索'),
          ),
      ],
      value: isSelectedValue,
      onChanged: (String? value) {
        setState(() {
          isSelectedValue = value!;
        });
      },
    );
  }
}