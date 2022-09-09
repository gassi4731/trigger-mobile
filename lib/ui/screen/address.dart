import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String postCode = '';
  String prefecture = '';
  String city = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自宅の住所入力'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
              hintText: '郵便番号',
            ),
            autofocus: true,
            onChanged: (text) {
              postCode = text;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: '都道府県',
            ),
            onChanged: (text) {
              prefecture = text;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: '市区町村',
            ),
            onChanged: (text) {
              city = text;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: '以降住所',
            ),
            onChanged: (text) {
              address = text;
            },
          ),
          ElevatedButton(
            child: const Text('送信'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
