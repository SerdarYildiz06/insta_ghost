import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_ghost/provider/api_provider.dart';
import 'package:instagram_ghost/view/content_page.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  PageController pageController = PageController();

  FocusNode focusNode = FocusNode();

  bool show = true;

  Timer? timer;

  List texts = [
    'Enter your Instagram username',
    'Make sure you entered the username correctly.',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(_onFocusChange);
    startTextAnimation();
  }

  void dispose() {
    super.dispose();
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  void _onFocusChange() {
    show = !focusNode.hasFocus;
    setState(() {});
  }

  void changeText() {
    pageController.animateTo(pageController.offset + 50,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void startTextAnimation() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      changeText();
    });
  }

  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            width: 300,
            child: Lottie.network(
                'https://assets10.lottiefiles.com/private_files/lf30_5jrklsmp.json'),
          ),
          Card(
            child: Text(
              'Enter the username you want to see the profile photo of.',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
                label: SizedBox(
                  height: 50,
                  child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      String text = texts[index % texts.length];
                      return Opacity(
                        opacity: show ? 1 : 0,
                        child: SizedBox(
                          height: 50,
                          width: 100,
                          child: Center(
                            child:
                                Align(alignment: Alignment.centerLeft, child: Text(text)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                floatingLabelStyle: const TextStyle(color: Colors.transparent),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style:
                  ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                apiProvider.fetch(userName: controller.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ContentPage()));
              },
              child: const Text(
                'Search',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
