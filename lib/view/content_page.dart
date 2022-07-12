import 'package:flutter/material.dart';
import 'package:instagram_ghost/provider/api_provider.dart';
import 'package:provider/provider.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    String? ppLink = apiProvider.ppLink;
    String? userName = apiProvider.name;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom, top: 10),
            child: Column(
              children: [
                Center(
                    child: Text(
                  userName.toString(),
                  style: TextStyle(fontSize: 20),
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ppLink != null
                        ? Image.network(ppLink)
                        : Container(
                            color: Colors.grey[200],
                            child: Center(child: CircularProgressIndicator())),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
