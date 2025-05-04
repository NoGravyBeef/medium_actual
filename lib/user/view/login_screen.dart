import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medium_actual/common/component/custom_text_form_field.dart';
import 'package:medium_actual/common/const/colors.dart';
import 'package:medium_actual/common/const/data.dart';
import 'package:medium_actual/common/layout/default_layout.dart';
import 'package:medium_actual/common/view/root_tab.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                SizedBox(height: 16),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
                CustomTextFormField(
                  hintText: "이메일을 입력해주세요",
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hintText: "비밀번호를 입력해주세요",
                  obscureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    // ID:비밀번호
                    final rawString = '$username:$password';

                    print(rawString);

                    Codec<String, String> stringToBase64 = utf8.fuse(
                      base64,
                    );
                    String token = stringToBase64.encode(rawString);

                    final resp = await dio.post(
                      'http://$ip/auth/login',
                      options: Options(
                        headers: {'authorization': 'Basic $token'},
                      ),
                    );

                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];
                    await storage.write(
                      key: REFRESH_TOKEN_KEY,
                      value: refreshToken,
                    );
                    await storage.write(
                      key: ACCESS_TOKEN_KEY,
                      value: accessToken,
                    );

                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (_) => RootTab()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "환영합니다!",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "이메일과 비밀번호를 입력해서 로그인 해주세요! \n 오늘도 성공적인 주문이 되길 :)",
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
