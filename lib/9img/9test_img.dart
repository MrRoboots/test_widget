import 'package:flutter/material.dart';
import 'package:test_stream/res/assets_res.dart';

class TestImg extends StatelessWidget {
  const TestImg({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          color: Colors.green,
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                constraints: const BoxConstraints(maxHeight: 400),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(AssetsRes.ABC),
                  centerSlice: Rect.fromLTRB(20, 20, 38, 38),
                )),
                child: ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(30),
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '哈哈哈哈哈哈哈哈哈哈',
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 100,
                    height: 20,
                    color: Colors.red,
                    child: const Text(
                      '标题',
                      textAlign: TextAlign.center,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
