import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intro_app_ui/utils/Strings.dart';

import 'home_page.dart';

class IntroPage extends StatefulWidget {
  static final String id = "intro_page";
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController? _pageController;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, HomePage.id);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Text('Skip', style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.w400),),
              )
          )
        ],
      ),*/

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page){
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              makePage(
                image: 'assets/images/image_1.png',
                title: Strings.stepOneTitle,
                content: Strings.stepOneContent
              ),
              makePage(
                  image: 'assets/images/image_2.png',
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent
              ),
              makePage(
                image: 'assets/images/image_3.png',
                title: Strings.stepThreeTitle,
                content: Strings.stepThreeContent,
                reverse: true
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // #skip
              Visibility(
                visible: (currentIndex == 2) ? true : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, HomePage.id);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            child: Text('Skip', style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w400),),
                          )
                      )
                    ],
                  ),
              ),
              // #indicator
              Container(
                margin: EdgeInsets.only(bottom: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
                ),
              ),
            ],)
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}){
    return
      Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(image),
                ),
                SizedBox(height: 10,),
              ],
            ),
            Text(title, style: TextStyle(
                color: Colors.red,
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 30,),
            Text(content, textAlign: TextAlign.center, style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w400
            ),),
          ],
        ),
      );
  }

  Widget _indicator(bool isActive){
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }

  List<Widget> _buildIndicator(){
    List<Widget> indicator = [];
    for (int i = 0; i < 3; i++){
      if (currentIndex == i){
        indicator.add(_indicator(true));
      } else {
        indicator.add(_indicator(false));
      }
    }
    return indicator;
  }

}
