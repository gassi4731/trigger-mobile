import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:trigger/ui/theme/padding_size.dart';

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

  late TextEditingController zipCodeController;
  late TextEditingController addressController;
  late FocusNode zipCodeFocusNode;
  late FocusNode addressFocusNode;

  @override
  void initState() {
    super.initState();

    zipCodeController = TextEditingController();
    addressController = TextEditingController();
    zipCodeFocusNode = FocusNode();
    addressFocusNode = FocusNode();
  }

  @override
  void dispose() {
    zipCodeController.dispose();
    addressController.dispose();
    zipCodeFocusNode.dispose();
    addressFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自宅の住所入力'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(PaddingSize.ps15),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    focusNode: zipCodeFocusNode,
                    controller: zipCodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '郵便番号',
                      suffixIcon: IconButton(
                        highlightColor: Colors.transparent,
                        icon: const SizedBox(
                          width: 36,
                          child: Icon(Icons.clear),
                        ),
                        onPressed: () {
                          zipCodeController.clear();
                          addressController.clear();
                        },
                        splashColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final result = await get(
                      Uri.parse(
                        'https://zipcloud.ibsnet.co.jp/api/search?zipcode=${zipCodeController.text}',
                      ),
                    );
                    final map = jsonDecode(result.body)['results'][0]
                        as Map<dynamic, dynamic>;
                    addressController.text =
                        '${map['address1']}${map['address2']}${map['address3']}';

                    addressFocusNode.requestFocus();
                  },
                  child: const Text('住所を検索'),
                )
              ],
            ),
            TextFormField(
              focusNode: addressFocusNode,
              controller: addressController,
              decoration: const InputDecoration(
                labelText: '都道府県+以降の住所',
              ),
            ),
            ElevatedButton(
              child: const Text('登録する'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
