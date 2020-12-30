import 'package:circle_action/Model/action_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controller/action_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // Si plusieurs annimation dans une page utiliser TickerProviderStateMixin
  AnimationController _animationController;
  Animation _animation;
  double _animBegin;
  double _animEnd;
  final ActionController _controller = ActionController();

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.bounceInOut);
    _animBegin = 0.0;
    _animEnd = _controller.getRandomPosition();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //identique à un initState mais avec le context se lance apres le initState ou apres des changements de dépendance
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ActionModel _action = _controller.getAction();
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                title: Center(
                    child: Text(
                  'Action !',
                  style: GoogleFonts.bangers(fontSize: 40.0),
                )),
                children: [
                  Text(
                    _action.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.indieFlower(fontSize: 30.0),
                  ),
                ],
              );
            });
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController
        .dispose(); //permet d'arreter l'annimation si on arrete l'app (évite les perte de mémoire)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Circle Action',
            style: GoogleFonts.bangers(fontSize: 70.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Lancer la roue pour obtenir un defi !',
            textAlign: TextAlign.center,
            style: GoogleFonts.bangers(fontSize: 40.0),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              children: <Widget>[
                Image.asset('assets/wheel.png'),
                RotationTransition(
                  turns: Tween(begin: _animBegin, end: _animEnd)
                      .animate(_animation),
                  child: GestureDetector(
                    onTap: () {
                      _animationController.forward();
                      if (_animationController.status ==
                          AnimationStatus.completed) {
                        setState(() {
                          _animBegin = _animEnd - _animEnd.truncate();
                          _animEnd = _controller.getRandomPosition();
                        });
                        _animationController.reset();
                        _animationController.forward();
                      }
                    },
                    child: Image.asset('assets/arrow.png'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
