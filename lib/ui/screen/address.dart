import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trigger/ui/screen/search_current_location.dart';
import 'package:trigger/ui/theme/padding_size.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
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

  Future<void> tapSearchAddress() async {
    final result = await get(
      Uri.parse(
        'https://zipcloud.ibsnet.co.jp/api/search?zipcode=${zipCodeController.text}',
      ),
    );
    final map = jsonDecode(result.body)['results'][0] as Map<dynamic, dynamic>;
    addressController.text =
        '${map['address1']}${map['address2']}${map['address3']}';

    addressFocusNode.requestFocus();
  }

  Future<void> tapRegister() async {
    if (zipCodeController.text != '' &&
        zipCodeController.text.length == 7 &&
        addressController.text != '') {
      // 値を保存
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isRegisteredAddress', true);
      await prefs.setString('zipCode', zipCodeController.text);
      await prefs.setString('address', addressController.text);

      // 画面遷移
      await Navigator.of(context).pushReplacement<dynamic, dynamic>(
        MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: '/detail'),
          builder: (context) {
            return const SearchCurrentLocation();
          },
        ),
      );
    }
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
                    await tapSearchAddress();
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
            const SizedBox(height: PaddingSize.ps15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: tapRegister,
                child: const Text('登録する'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
