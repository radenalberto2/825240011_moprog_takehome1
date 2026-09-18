import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  int likes = 10;
  bool selected = false;
  String message = '';

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body:SafeArea(child:
        Container(
          //  width: screenWidth *0.9,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          color: Colors.blue.shade200,
          child: Column(
            children: [

              Row(
                children: [
                  const Text(
                    'My Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  Spacer(),
                  Text('Edit')
                ],
              ),
              Stack(
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: selected? Colors.blue : Colors.transparent,
                                width: 5
                            )
                        ),
                        child: Image.network('https://i.pravatar.cc/',
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace){
                            return Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color:  Colors.grey.shade500,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person,
                                color:Colors.grey, size: 100,),
                            );
                          },
                          width: 120,
                          height: 120,
                        ),
                      )

                  ),

                  const Positioned(
                      right: 0,
                      bottom: 0,
                      child: Icon(Icons.edit) ),
                ],
              ),

              Container(
                child: Column(
                  children: [
                    SizedBox(width: 10,
                      child: Icon(Icons.favorite),
                    ),
                    SizedBox(width: 20,
                      child: Text('$likes'),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Text('Daniel Witarsa'),
              const SizedBox(height: 20),
              const Text('daniel.825240106@stu.untar.ac.id'),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(right: 5),
                        color: Colors.blue,
                        child: const Text('Workout',
                          textAlign: TextAlign.center,
                        ),
                      )),
                  Expanded(
                      flex: 1,

                      child: Container(
                        padding: const EdgeInsets.all(15),
                        color: Colors.green,
                        child: const Text('Progress',
                          textAlign: TextAlign.center,
                        ),
                      )),

                ],
              )
            ],
          ),
        ),
        ),
      ),
    );
  }
}