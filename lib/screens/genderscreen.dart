import 'package:flutter/material.dart';
import 'package:nexthack/screens/imagepickscreen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _controller1;
  late Animation<double> _animation1;
  String gender = '';

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation1 = CurvedAnimation(
      parent: _controller1,
      curve: Curves.decelerate,
    );

    _controller1.forward();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller.dispose();

    super.dispose();
  }

  void _selectGender(String selectedGender) {
    setState(() {
      gender = selectedGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/genderpage.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            height: 800,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FadeTransition(
                      opacity: _animation1,
                      alwaysIncludeSemantics: false,
                      child: SlideTransition(
                        textDirection: TextDirection.ltr,
                        position: Tween<Offset>(
                          begin: Offset(0, 1),
                          end: Offset(0, 0),
                        ).animate(_animation1),
                        child: Container(
                          height: 500,
                          width: double.maxFinite,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            backgroundBlendMode: BlendMode.difference,
                            color: Color.fromRGBO(114, 80, 161, 1),
                            borderRadius: BorderRadiusDirectional.vertical(
                                top: Radius.elliptical(360, 190)),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Color.fromRGBO(114, 80, 161, 1),
                                  Color.fromARGB(255, 138, 79, 152),
                                ]),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _animation.value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            Colors.purple,
                                            Colors.transparent
                                          ],
                                          stops: [0.5, 1],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.purple.withOpacity(0.6),
                                            blurRadius: 20,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.black,
                                        child: Image.asset(
                                          'assets/logo.png',
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 35),
                              Text(
                                'Can you help Genie choose your preferred wear style?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "Georgia"),
                              ),
                              SizedBox(height: 30),
                              ElevatedButton(
                                  onPressed: () => _selectGender('male'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: gender == 'male'
                                        ? Colors.purple[900]
                                        : Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "👕",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: gender == 'male'
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "MEN's FASHION WEAR",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Georgia",
                                          color: gender == 'male'
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )),
                              SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () => _selectGender('female'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: gender == 'female'
                                      ? Colors.purple[900]
                                      : Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "👚",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: gender == 'female'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "WOMEN's FASHION WEAR",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Georgia",
                                        color: gender == 'female'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: gender.isNotEmpty
                                    ? () {
                                        print(gender);
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImagePickScreen(
                                                          gender: gender)));
                                        });
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                ),
                                child: Text(
                                  'Let\'s go Genie  ✨',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
