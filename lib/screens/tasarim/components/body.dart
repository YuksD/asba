import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(flex: 2,
              child: Container(color: Colors.white,
                child: Column(
                  children: [
                  Expanded(flex:1 ,child: SizedBox(),),

                    Expanded(flex:1,
                      child: Row(mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Column(
                        children:[
                        SizedBox( child: Card(child: Text('1231241'))),
                        Container(color: Colors.amber,height: 300,)
                                        ]),
                                        TextButton(onPressed: () {}, child: Text('yuksel'))
                                        ],
                                      
                                        ),
                    ),
                  Expanded(flex:1 ,child: SizedBox(),),

                  Column(
                    children: [
                      Card(child: ListTile(title: Text('Ahmet YANBASTI') ,)),
                    ],
                  ),
                  Expanded(flex:1 ,child: SizedBox(),),


                  Column(
                    children: [
                      Card(child: ListTile(title: Text('Ahmet YANBASTI') ,)),
                    ],
                  ),
                  Expanded(flex:1 ,child: SizedBox(),),

                
                  ],
                ),
              )),
            Expanded(flex: 3,
              child: Container(
                color: Colors.red,)),
          ],
        ),
      ),
    );
  }
}