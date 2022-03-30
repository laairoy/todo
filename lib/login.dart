

import 'package:flutter/material.dart';


void main() {
  runApp(   MyApp());
}

class MyApp extends StatefulWidget {
 
     MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:   MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
    MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
double add(double a , double b){
  print(a+b);
  a=a+b;
  return a;
} 
  bool lembrar = false;
  bool passx = true;
   bool butaozinho = false;
   bool falci = false;
   bool chkt = false;
   String texc = ''; 
   String cuzinh = 'cuxi';
   String cuzin2 = "true";
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  
  Widget build(BuildContext context) {
  
    Size size = MediaQuery.of(context).size;
    final kex = MediaQuery.of(context).viewInsets.bottom;
    double widthx = size.width;
    double heightx = size.height;
    print(widthx);
     print(heightx);
     
     double vax =0;
     double vax2 =0;
     double vax3 =0;
     double vax4 =0;
     double vax5 =0;
     print(vax);
     if(kex>1){
       vax4=0;
       vax5=0.1*heightx;
     }
     else{
       vax4=0.1*heightx;
       vax5=0;
     }
 
     

    return Scaffold(
      
      body:  Container(
        color:   Color.fromARGB(171, 235, 232, 224),
      height: double.maxFinite,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
          
        ),
        child: Stack(
         
            children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: vax4),
          margin:   EdgeInsets.all(0),
          height: vax=0.25*heightx-vax5/2,
          child: Table(
            border: TableBorder.symmetric(
                inside:   BorderSide(width: 3, color: Colors.transparent),
                outside:   BorderSide(width: 3, color: Colors.transparent)),
            columnWidths:   {
              0: FractionColumnWidth(0.08),
              1: FractionColumnWidth(0.7),
              2: FractionColumnWidth(0.17),
              3: FractionColumnWidth(0.1),
            },
             
            children: [
              TableRow(children: [
                Container(
                  height: 0.15*heightx, padding: EdgeInsets.only( top: 0.015*heightx),
                  child: Text('',
                 
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.075*heightx ), ),
                ),
               
               


                Container(
                   height: 0.15*heightx, padding: EdgeInsets.only( top: 0.15*heightx/3),
                  child: Text('Log in',
                  
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 0.075*heightx ,fontWeight: FontWeight.bold), ),
                    ),
                   Container(
                   height: 0.05*heightx, padding: EdgeInsets.only( top: 0.015*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold), ),
                    ),
              ]),
                ],
          ),
        ),
        //Text(add(vax, vax2).toString()),
           Container(
          padding: EdgeInsets.only(top: vax2=vax-vax5/2),
          margin:   EdgeInsets.all(0),
          height: vax3=0.3*heightx+vax-vax5/2,
          alignment: FractionalOffset.bottomLeft,

          child: Table(
            border: TableBorder.symmetric(
                inside:   BorderSide(width: 3, color: Colors.transparent),
                outside:   BorderSide(width: 3, color: Colors.transparent)),
            columnWidths:   {
               0: FractionColumnWidth(0.1),
              1: FractionColumnWidth(0.8),
              2: FractionColumnWidth(0.05),
              3: FractionColumnWidth(0.05),
            },
            children: [
              TableRow(children: [
                Container(
                  height: 0.01*heightx, padding: EdgeInsets.only( top: 0.015*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold), ),
                ),
                
                Container(
                   height: 0.01*heightx, padding: EdgeInsets.only( top: 0.01*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold), ),
                    ),
                   Container(
                   height: 0.01*heightx, padding: EdgeInsets.only( top: 0.01*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.01*heightx ,fontWeight: FontWeight.bold), ),
                    ),
              ]),
              TableRow(children: [
               
                Container(height: 0.05*heightx, //padding: EdgeInsets.only( top: 0.0*heightx),
                  
                alignment: Alignment.center, child: Text('', textAlign: TextAlign.center,style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold),)),
                 Column(
                   
                crossAxisAlignment: CrossAxisAlignment.end,
    children:   <Widget>[
      
                
                
      SizedBox(
        height: heightx*0.1,
        child: TextField(
          
        enabled: true, // to trigger disabledBorder
 decoration: InputDecoration(
    prefixIcon: Icon(Icons.mail_outline),
   filled: true,
   fillColor: Color(0xFFF2F2F2),

   focusedBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(6)),
     borderSide: BorderSide(width: 2,color: Colors.red)),

         disabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(6)),
     borderSide: BorderSide(width: 2,color: Colors.orange),
   ),
   enabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(6)),
     borderSide: BorderSide(width: 2,color: Colors.green),
   ),
        errorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(6)),
     borderSide: BorderSide(width: 2,color: Colors.black)
   ),
   focusedErrorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(6)),
     borderSide: BorderSide(width: 2,color: Colors.yellowAccent)
   ),
   hintText: "Email",
   
   hintStyle: TextStyle(fontSize: heightx*0.04,color: Color(0xFFB3B1B1)),
   //errorText: snapshot.error,
 ),
 //controller: _passwordController,
 //onChanged: _authenticationFormBloc.onPasswordChanged,
                              
),
      ),
      
      
    ],
  ),
  

             
                 Container(height: 0.05*heightx, //padding: EdgeInsets.only( top: 0.0*heightx),
                  
                alignment: Alignment.center, child: Text('', textAlign: TextAlign.center,style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold),)),
 
              ]),
              TableRow(children: [
                 
                Container(
                  height: 0.02*heightx, padding: EdgeInsets.only( top: 0.015*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold), ),
                ),
                
                Container(
                   height: 0.01*heightx, padding: EdgeInsets.only( top: 0.01*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold), ),
                    ),
                   Container(
                   height: 0.01*heightx, padding: EdgeInsets.only( top: 0.01*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.01*heightx ,fontWeight: FontWeight.bold), ),
                    ),
              ]),
  
              TableRow(children: [
                  Text('', textAlign: TextAlign.end),
                
                 Column(
                
    children:   <Widget>[
      
                
                
        SizedBox(
          height: heightx*0.1,
          child: TextField(
          
  obscureText: passx,
      enabled: true, // to trigger disabledBorder
   decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {setState(() {
                      passx = !passx;
                      print(passx.toString());
                    });}),
   filled: true,
   fillColor: Color(0xFFF2F2F2),

   focusedBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(6)),
     borderSide: BorderSide(width: 2,color: Colors.red)),

       disabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(6)),
     borderSide: BorderSide(width: 2,color: Colors.orange),
   ),
   enabledBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(6)),
     borderSide: BorderSide(width: 2,color: Colors.green),
   ),
      errorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(6)),
     borderSide: BorderSide(width: 2,color: Colors.black)
   ),
   focusedErrorBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(6)),
     borderSide: BorderSide(width: 2,color: Colors.yellowAccent)
   ),
   hintText: "Password",
   hintStyle: TextStyle(fontSize: heightx*0.04,color: Color(0xFFB3B1B1)),
   //errorText: snapshot.error,
 ),
 //controller: _passwordController,
 //onChanged: _authenticationFormBloc.onPasswordChanged,
                              
),
        ),
      
      
    ],
  ),
  

               Text('', textAlign: TextAlign.end),
              ]),
             
              TableRow(children: [
                Container(
                  height: 0.01*heightx, padding: EdgeInsets.only( top: 0.015*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold), ),
                ),
                
                Container(
                   height: 0.01*heightx, padding: EdgeInsets.only( top: 0.01*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold), ),
                    ),
                   Container(
                   height: 0.01*heightx, padding: EdgeInsets.only( top: 0.01*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.01*heightx ,fontWeight: FontWeight.bold), ),
                    ),
              ]),
              TableRow(children: [
                Container(height: 0.05*heightx, //padding: EdgeInsets.only( top: 0.0*heightx),
                  
                alignment: Alignment.center, child: Text('', textAlign: TextAlign.center,style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold),)),
                   Column(children: [
                  // ignore: deprecated_member_use
                 Container(
      width: 0.8*widthx,
      height: 0.05*heightx,
      margin: new EdgeInsets.all(0.01*heightx),
       decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 32, 48, 32), Color.fromARGB(255, 26, 116, 29)])),
  child: ElevatedButton(
    onPressed: () {},
       style: ElevatedButton.styleFrom(primary: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular( 0.01*heightx,),
    ),),
      child: Text('LOGIN'),
  )
                 ),
                
                Text('',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ]),

             
                 Container(height: 0.05*heightx, //padding: EdgeInsets.only( top: 0.0*heightx),
                  
                alignment: Alignment.center, child: Text('', textAlign: TextAlign.center,style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold),)),
 
              ]),
            
            
            ],
          ),
        ),
       Container(
          alignment: FractionalOffset.bottomLeft,
          margin:   EdgeInsets.all(0),
          height: vax3+0.12*heightx,
          child: Table(
            border: TableBorder.symmetric(
                inside:   BorderSide(width: 3, color: Colors.transparent),
                outside:   BorderSide(width: 3, color: Colors.transparent)),
            columnWidths:   {
              0: FractionColumnWidth(0.1),
              1: FractionColumnWidth(0.4),
              2: FractionColumnWidth(0.4),
              3: FractionColumnWidth(0.1),
            },
             
            children: [
               TableRow(children: [
                Container(
                  height: 0.01*heightx, padding: EdgeInsets.only( top: 0.015*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold), ),
                ),
                
                Container(
                   height: 0.01*heightx, padding: EdgeInsets.only( top: 0.01*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.02*heightx ,fontWeight: FontWeight.bold), ),
                    ),
                   Container(
                   height: 0.01*heightx, padding: EdgeInsets.only( top: 0.01*heightx),
                  child: Text('',
                  
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.01*heightx ,fontWeight: FontWeight.bold), ),
                    ),
              ]),
              
              TableRow(children: [
                Container(
                  height: 0.1*heightx, padding: EdgeInsets.only( top: 0.015*heightx),
                  child: Text('',
                 
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.075*heightx ), ),
                ),
               
   Container(
      //width: 0.8*widthx,
      height: 0.05*heightx,
      
       decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.transparent])),
  child: ElevatedButton.icon(
     style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          fixedSize: const Size(208, 43),
        ),
     icon: chkt ? Icon(
            Icons.check_circle_outline,
             color: Colors.pink,
            size: 0.04*heightx,
          ):
          Icon(
            Icons.circle_outlined,
             color: Color.fromARGB(255, 37, 233, 30),
            size: 0.04*heightx,
          ),

    label: Text('Lembrar',style: TextStyle(
        fontSize: 0.03*heightx,
        color: Color.fromARGB(255, 32, 6, 95),)),
          onPressed: () {
            setState(() {
              chkt = !chkt;
            });
            print('Pressed');
          },
       ),
   ),
              

            
                   Container(
                     alignment: Alignment.topRight,
                   height: 0.1*heightx, padding: EdgeInsets.only( top: 0*heightx),
                   child: TextButton(
              // 3
              onPressed: falci
                  ? () {
                      print('eita');
                    }
                  : null,
              child: Text( lala(falci),style: TextStyle(fontSize: 0.03*heightx ,color:  Colors.red,)),
            ),
                    ),
              ]),
                ],
          ),
        ),
    
        Container(

          
          alignment: FractionalOffset.bottomCenter,
          margin:   EdgeInsets.all(0),
           height: heightx*0.95,
          child: Table(
            border: TableBorder.symmetric(
                inside:   BorderSide(width: 3, color: Colors.transparent),
                outside:   BorderSide(width: 3, color: Colors.transparent)),
            columnWidths:   {
              0: FractionColumnWidth(0.05),
              1: FractionColumnWidth(0.8),
              2: FractionColumnWidth(0.05),
              3: FractionColumnWidth(0.05),
            },
            children: [
                TableRow(children: [
                Text('',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                
                 Container(
      width: 0.8*widthx,
      height: 0.05*heightx,
      
       decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 32, 48, 32), Color.fromARGB(255, 26, 116, 29)])),
  child: ElevatedButton(
    onPressed: () {},
       style: ElevatedButton.styleFrom(primary: Colors.transparent, shadowColor: Colors.transparent,  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),),
    child: Text('CADASTRO'),
  )
                 ),
                
                Text('',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
           ],
          ),
        ),
        ],
          ),
        ),
      ),
    
  );
}

String lala(bool x){
if (x == false){
return ' esqueceu ? ';
}
else{
 return 'esqueceu passworld ?';
}
}

}