import 'package:flutter/material.dart';
class Badges extends StatelessWidget{
  final Widget child;
  final Color color;
  final String value;
  const Badges({
    Key key,
    @required this.color,
    @required this.value,
    @ required this.child,

}):super (key: key);


  @override
  Widget build(BuildContext context) {
    print(value);
    return Stack(
     children: [
       child,
       Positioned(child: Text(
         value.toString(),
       ),
         top: 4,
       ),



     ],
    );
  }
}
