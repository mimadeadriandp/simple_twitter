import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:simple_twitter/app/infrastructures/app_component.dart';
import 'package:simple_twitter/app/ui/pages/home/controller.dart';
import 'package:simple_twitter/app/ui/widgets/loading.dart';

class HomePage extends View {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState(
      AppComponent.getInjector().getDependency<HomeController>());
}

class _HomePageState extends ViewState<HomePage, HomeController>
    with WidgetsBindingObserver {
  _HomePageState(HomeController controller) : super(controller) ;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget buildPage() {
    double scaleWidth = MediaQuery.of(context).size.width / 360;
    return new Scaffold(
      key: globalKey,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("HOME"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                controller.signOut();
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
              child: Container(
                alignment: Alignment.center,
                height: 35 * scaleWidth,
                child: AutoSizeText(
                  "Log Out",
                  style: TextStyle(fontSize: 16, color: Colors.red[400]),
                ),
              ))
        ],
      ),
      body: controller.tweets.snapshots() == null
          ? CommonLoading()
          : Center(
              child: StreamBuilder(
                stream: controller.tweets
                    .orderBy('updatedat', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CommonLoading();
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 55 * scaleWidth,
                                    width: 55 * scaleWidth,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(
                                            60 * scaleWidth)),
                                    child: Text(snapshot
                                        .data.docs[index]['username']
                                        .toString()
                                        .substring(0, 1)
                                        .toUpperCase()),
                                  ),
                                  SizedBox(
                                    width: 16 * scaleWidth,
                                  ),
                                  Container(
                                    width: 220 * scaleWidth,
                                    // color: Colors.blueAccent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            snapshot.data.docs[index]
                                                ['username'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10 * scaleWidth,
                                        ),
                                        Container(
                                          child: Text(snapshot.data.docs[index]
                                              ['tweets']),
                                        ),
                                        SizedBox(
                                          height: 10 * scaleWidth,
                                        ),
                                        Container(
                                          child: Text((snapshot.data.docs[index]
                                                  ['updatedat'] as Timestamp)
                                              .toDate()
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8 * scaleWidth,
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.openEditDialog(
                                              snapshot, index);
                                        },
                                        child: Icon(
                                          Icons.edit,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20 * scaleWidth,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.deleteTweet(
                                              snapshot, index);
                                        },
                                        child: Icon(
                                          Icons.delete,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.black26,
                                thickness: 1,
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.openDeleteDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
