import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'screens/auth/login.dart';
import 'screens/auth/signup.dart';
import 'tab/tab.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Splash(),
));

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() { 
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      );
    _controller.repeat();
    Future.delayed(Duration(seconds: 4), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
      
  @override
  Widget build(BuildContext context) {
    final threedots = Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle
                          ),
                        ),

                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(26, 28, 248, 1),
                            shape: BoxShape.circle
                          ),
                        ),

                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(26, 28, 248, 1),
                            shape: BoxShape.circle
                          ),
                        ),
                      ],
                    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
                child: Center(
                  child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 100.0),
                                child: Column(
                                  children: <Widget>[
                                              Container(
                                                child: Image.asset('images/splashimg.jpg'),
                                              ),
                                              SizedBox(height: 50.0),
                                              Text('Welcome', style: TextStyle(color: Color.fromRGBO(26, 28, 248, 1), fontSize: 35.0, fontWeight: FontWeight.bold, )),
                                              SizedBox(height: 30.0),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(30, 20, 30, 20), 
                                                child: Center(
                                                  child: Text('Elit veniam officia proident dolore do proident do amet elit in. Laborum ullamco cillum et ullamco. Amet magna cillum cillum',
                                                                style: TextStyle(color: Color.fromRGBO(79, 75, 75, 1), ),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                )),
                                                SizedBox(height: 50.0),

                                                // 3 Dots
                                                Center(
                                                  child: AnimatedBuilder(
                                                    animation: _controller.view,
                                                    builder: (context, child) {
                                                      return Transform.rotate(angle: _controller.value * 2 * 3.142, child: child,);
                                                    },
                                                      child: threedots,
                                                  ),
                                                ),
                                  ],
                                ),
                              ),
                            // Bottom rectangular Bar
                                Container(
                                  height: 15,
                                  width: MediaQuery.of(context).size.width * 0.90,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(26, 28, 248, 1),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)
                                      ),
                                    gradient: LinearGradient(colors: [Color.fromRGBO(26, 28, 248, 1), Color.fromRGBO(14, 179, 243, 1)])
                                    
                                  )

                                )
                              
                            ],
                  )
                ),
      )
    );
  }
}
