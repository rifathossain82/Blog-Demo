import 'package:blog_with_provider_demo/src/network/api.dart';
import 'package:blog_with_provider_demo/src/network/network_utils.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  void get() async {
    try {
      dynamic responseBody = await Network.handleResponse(
        await Network.getRequest(
          api: API.getAllBlogs,
        ),
      );

      print(responseBody);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    get();
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Demo'),
      ),
    );
  }
}
