
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PhysicsSimulationApp(title: 'Physics simulation app'),
    );
  }
}

// object elements

class ProjectileBall
{
  late double u;
  late double theta;
  late double t;
  late double g; // use const double g = 9.8;
  late double x;
  late double y;

  ProjectileBall(double u, double theta)
  {
    x = 0.0;
    y = 0.0;
    t = 0.0;
    // g = 3; // g = 9.8;

    g = 1;

    // u, theta: take user inputs

    this.u = u;
    this.theta = theta;

    // setting the values of 'u' and 'theta'
  }

  // ProjectileBall()
  // {
  //   x = 0.0;
  //   y = 0.0;
  //   t = 0.0;
  //   // g = 3; // g = 9.8;

  //   g = 1;

  //   // u, theta: take user inputs
  // }

  updateX(t)
  {
    // These trigonometric functions use radians, not degrees!

    // x = u * math.cos(theta) * t;   // x(t), results in time X-axis (in equivalent graph) (as the parameter connecting x(t) and y(t) is t) and a compressed parabola

    x = t;   // x(x = t), t is just the connecting parameter here, results in distance X-axis (in equivalent graph) (as the parameter connecting x(x = t) and y(x = t) is x) and a proper spread-out parabola (that of y = f(x) graph)  

    // x = 10.0 * t;

    // x = 0.001 * t;

    // x = 30.0;

    // x = 30.0 + t - 1306.0;

    // x = t;
  }

  updateY(t)
  {
    // These trigonometric functions use radians, not degrees!

    // y = (u * math.sin(theta) * t) - ((g * math.pow(t, 2)) / 2);   // y(t), results in time X-axis (in equivalent graph) (as the parameter connecting x(t) and y(t) is t) and a compressed parabola  

    y = (t * math.tan(theta)) - ((g * math.pow(t, 2)) / (2 * math.pow(u, 2) * math.pow(math.cos(theta), 2)));   // y(x = t), t is just the connecting parameter here, results in distance X-axis (in equivalent graph) (as the parameter connecting x(x = t) and y(x = t) is x) and a proper spread-out parabola (that of y = f(x) graph)

    // y = 583.0 - y;  // as the canvas's origin is at top-left corner and hence, this sets the coordinate (y) right

    // y = 50.0 * t;

    // y = 0.005 * t;

    // y = 30.0;

    // y = 30.0 + t - 523.0;

    // y = t;
  }

}

class SimplePendulum
{
  late double l;  // take input   // l: 'effective length' of the pendulum
  late double A;  // take input   // constraint: 0 < A <= l
  late double radius;   // radius: radius of the bob
  late double g;
  late double omega;    // omega: angular frequency of the pendulum
  late double x;
  late double y;
  late double t;

  // assumptions: the bob is small in size and is light, the string is light and inextensible, there is no air resistance, the pendulum's displacements are small


  // class object

  SimplePendulum(this.l, this.A)
  {
    x = A;
    y = math.sqrt(math.pow(l, 2) - math.pow(A, 2));

    t = 0.0;
    g = 3;
    radius = 20.0;
    omega = math.sqrt(g / l);
  }

  // class methods

  updateX(t)
  {
    x = A * math.cos(omega * t);

    // These trigonometric functions use radians, not degrees!
  }

  updateY()
  {
    y = math.sqrt(math.pow(l, 2) - math.pow(x, 2));
  }
}

class WaveMotionParticle
{
  late double v;
  late double lambda;
  late double A;
  late double phi;
  late double radius;
  late double omega;
  late double k;
  late double c1;
  late double c2;
  late double x;
  late double y;
  late double t;

  WaveMotionParticle(this.v, this.lambda, this.A, this.phi, this.radius, this.c1, this.c2)
  {
    omega = 2 * math.pi * (v / lambda);
    
    k = ((2 * math.pi) / lambda);

    t = 0.0;  // can be set in initState
  }

  updateX(t)
  {
    x = ((c1 * t) + c2);
  }

  updateY(t)
  {
    y = A * math.sin((k * x) - (omega * t) + phi);

    // These trigonometric functions use radians, not degrees!
  }
}

class PhysicsSimulationApp extends StatefulWidget {
  const PhysicsSimulationApp({super.key, required this.title});

  final String title;
  
  @override
  _PhysicsSimulationAppState createState() => _PhysicsSimulationAppState();
}

class _PhysicsSimulationAppState extends State<PhysicsSimulationApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Physics simulation app',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Physics simulation app',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 55.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 80.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action for Button 1
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PurplePageProjectileMotion(title: 'Projectile motion')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 45, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Projectile motion',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for Button 2
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PurplePagePendulumOscillation(title: 'Pendulum oscillation')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 45, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Pendulum oscillation',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for Button 3
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PurplePageWaveParticleMotion(title: 'Wave particle motion')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 45, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Wave particle motion',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PurplePageProjectileMotion extends StatefulWidget {
  const PurplePageProjectileMotion({super.key, required this.title});

  final String title;
  
  @override
  _PurplePageProjectileMotionState createState() => _PurplePageProjectileMotionState();
}

class _PurplePageProjectileMotionState extends State<PurplePageProjectileMotion> {
  double inputValue1 = 35;
  double inputValue2 = 0.7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 155, 97, 165),
      appBar: AppBar(
        title: Text(
          'Projectile motion simulation',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Projectile motion simulation',
              style: TextStyle(
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        inputValue1 = double.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'input u',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 169, 233, 172),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 120,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        inputValue2 = double.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'input theta',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 169, 233, 172),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform any action you want with inputValue1 and inputValue2
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SimulationPageProjectileMotion()),
                );

                //
                print('Value 1: $inputValue1, Value 2: $inputValue2');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Enter',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => HomePage(inputValue1, inputValue2)),
                  MaterialPageRoute(builder: (context) => SimulationPageProjectileMotion()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              child: Icon(
                Icons.play_arrow,
                size: 60,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TheoryPageProjectileMotion()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              child: Text(
          'Theory',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
            ),
          ],
        ),
      ),
    );
  }
}

class TheoryPageProjectileMotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Projectile motion theory',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          "Projectile motion" +
"\n\n-> Theory:" + 
"\nThe motion of a body thrown in air, at a certain angle, is known as ‘Projectile motion’" +
"\nand that body is known as ‘projectile’. In the absence of air resistance (drag), the path" +
"\nof the projectile (trajectory) is a parabola (a mathematical curve)." +
"\n\n-> Parameters:" +
"\n• u: initial velocity / velocity of projection" +
"\n• θ: angle of projection" +
"\n• g: Earth’s gravitational acceleration" +
"\n• t: time instant ‘t’" +
"\n• x(t): x-coordinate of the projectile as a function of t" +
"\n• y(t): y-coordinate of the projectile as a function of t" +
"\n\n-> Equations:" +
"\nx(t) = u.cosθ.t" +
"\ny(t) = u.sinθ.t − g.t2/2" +
"\ny = f(x) = x.tanθ − g.x2.sec2θ/2.u2"
,
          style: TextStyle(
            fontSize: 21,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SimulationPageProjectileMotion extends StatefulWidget
{
  const SimulationPageProjectileMotion({super.key});

  // final double inputValue1;
  // final double inputValue2;

  // HomePage(this.inputValue1, this.inputValue2);


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  // @override
  // State<HomePage> createState() => _HomePageState(inputValue1, inputValue2);

  @override
  State<SimulationPageProjectileMotion> createState() => _SimulationPageProjectileMotionState();
}

class _SimulationPageProjectileMotionState extends State<SimulationPageProjectileMotion> 
{
  // final double inputValue1;
  // final double inputValue2;

  // _HomePageState(this.inputValue1, this.inputValue2);

  late Timer timer;

  late Stopwatch stopwatch;

  var ball = ProjectileBall(35, 0.7);

  // ball.u = inputValue1;
  // ball.theta = inputValue2;

  final double BallCircleX = 100.0;
  final double BallCircleY = 40.0;

  @override
  void initState()
  {
    // u, theta: take user inputs

    // const double BallCircleX = 90.0;
    // const double BallCircleY = 90.0;

    stopwatch = Stopwatch();

    stopwatch.start();

    update();

    super.initState();
  }


  void update()
  {
    // the main 'update' method and 'set state' method of the app

    timer = Timer.periodic
    (
      const Duration(milliseconds: 50), // milliseconds: 16
      (timer) 
      { 
        // ball.updateX(t);
        // ball.updateY(t);

        // take 'u', 'theta' as user inputs

        // ball.updateX(timer.tick);
        // ball.updateY(timer.tick);

        ball.updateX((stopwatch.elapsedMilliseconds) / 7);
        ball.updateY((stopwatch.elapsedMilliseconds) / 7);

        // shifting the origin (0, 0) to (BallCircleX, BallCircleY), the initial position of the ball

        ball.x = BallCircleX + ball.x;
        ball.y = BallCircleY + ball.y;

        ball.y = 583.0 - ball.y;  // as the canvas's origin is at top-left corner and hence, this sets the coordinate (y) right

        // 583.0 can be changed to a dynamic variable value (as per screen canvas)

        /*
            " Canvas's origin is at top left corner "

            Canvas dimenions:- 
            
            full screen dimensions (with debug banner): 1366 x 768

            blank canvas dimensions (without debug banner): 1366 x 583

        */

        setState(() {});
      }
    );
  }

  @override
  void dispose() 
  {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    // the main 'build' method of the app

    return Scaffold
    (
        backgroundColor: Colors.black,
        appBar: AppBar
        (
          title: const Text('Flutter Physics Simulation App - projectile motion'),
        ),
        body: InteractiveViewer
        (
          child: CustomPaint
          (
            painter: BallPainter(ball.x, ball.y),
            child: Container(),
          ),
        )
    );
  }
}

class BallPainter extends CustomPainter 
{
  // final vector_math.Vector2 anchor;
  // final vector_math.Vector2 child;

  // late double X;
  // late double Y;  

  final double X;
  final double Y;

  BallPainter(this.X, this.Y);

  @override
  void paint(Canvas canvas, Size size)
  {
    Paint BallPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(X, Y), 30, BallPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) 
  {
    return true;
  }

}

class PurplePagePendulumOscillation extends StatefulWidget {
  const PurplePagePendulumOscillation({super.key, required this.title});

  final String title;
  
  @override
  _PurplePagePendulumOscillationState createState() => _PurplePagePendulumOscillationState();
}

class _PurplePagePendulumOscillationState extends State<PurplePagePendulumOscillation> {
  double inputValue1 = 275;
  double inputValue2 = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 155, 97, 165),
      appBar: AppBar(
        title: Text(
          'Pendulum oscillations, Simple Harmonic Motion',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pendulum oscillations, Simple Harmonic Motion',
              style: TextStyle(
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        inputValue1 = double.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'input l',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 169, 233, 172),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 120,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        inputValue2 = double.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'input A',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 169, 233, 172),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform any action you want with inputValue1 and inputValue2
                Navigator.push(context,
                  // MaterialPageRoute(builder: (context) => HomePage(inputValue1, inputValue2)),
                  MaterialPageRoute(builder: (context) => SimulationPagePendulumOscillation()),
                );

                //
                print('Value 1: $inputValue1, Value 2: $inputValue2');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Enter',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => HomePage(inputValue1, inputValue2)),
                  MaterialPageRoute(builder: (context) => SimulationPagePendulumOscillation()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              child: Icon(
                Icons.play_arrow,
                size: 60,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TheoryPagePendulumOscillation()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              child: Text(
          'Theory',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
            ),
          ],
        ),
      ),
    );
  }
}

class TheoryPagePendulumOscillation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pendulum oscillation theory',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          "Pendulum oscillations" +
"\n\n-> Theory:" + 
"\nA simple pendulum consists of a ball (known as bob) (point-mass) m hanging from a" +
"\n(massless) string of length L and fixed at a pivot point P. When displaced to an initial" +
"\nangle and released, the pendulum will swing back and forth with periodic motion." +
"\nThe ‘effective length’ of a pendulum is the distance between the point of suspension" +
"\nand the centre of gravity of the bob." +

"\n\n-> Parameters:" +
"\n• l: effective length of the pendulum" +
"\n• A: amplitude of oscillations of the pendulum" +
"\n• ω: angular frequency of the pendulum" +
"\n• g: Earth’s gravitational acceleration" +
"\n• t: time instant ‘t’" +
"\n• x(t): x-coordinate of the centre of the bob as a function of t" +
"\n• y(t): y-coordinate of the centre of the bob as a function of t" +

"\n\n-> Equations:" +
"\nx(t) = A.cos(ω.t) " +
"\ny(t) =[l2 − A2.cos2(ω.t)]1/2 "
,
          style: TextStyle(
            fontSize: 19,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SimulationPagePendulumOscillation extends StatefulWidget
{
  // const HomePage({Key? key}) : super(key: key);

  const SimulationPagePendulumOscillation({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<SimulationPagePendulumOscillation> createState() => _SimulationPagePendulumOscillationState();
}

class _SimulationPagePendulumOscillationState extends State<SimulationPagePendulumOscillation> 
{
  late Timer timer;

  late Stopwatch stopwatch;

  var pendulum = SimplePendulum(275, 100);

  final double PivotPointX = 650.0;
  final double PivotPointY = 180.0;

  late double BobTopPointX;
  late double BobTopPointY;

  @override
  void initState()
  {
    // l, A: take user inputs

    // final double BobTopPointFactor = ((pendulum.l - pendulum.radius) / pendulum.l);

    // // setting initial values, at t = 0

    // BobTopPointX = BobTopPointFactor * pendulum.x;  // pendulum.x : here, x at t = 0
    // BobTopPointY = BobTopPointFactor * pendulum.y;  // pendulum.y : here, y at t = 0 

    stopwatch = Stopwatch();

    stopwatch.start();

    update();

    super.initState();
  }


  void update()
  {
    // the main 'update' method and 'set state' method of the app

    final double BobTopPointFactor = ((pendulum.l - pendulum.radius) / pendulum.l);

    // setting initial values, at t = 0

    BobTopPointX = BobTopPointFactor * pendulum.x;  // pendulum.x : here, x at t = 0
    BobTopPointY = BobTopPointFactor * pendulum.y;  // pendulum.y : here, y at t = 0

    timer = Timer.periodic
    (
      const Duration(milliseconds: 50), // milliseconds: 16
      (timer) 
      { 
        // pendulum.updateX(t);
        // pendulum.updateY();

        // updating coordinates of the centre of the bob

        pendulum.updateX((stopwatch.elapsedMilliseconds) / 30);
        pendulum.updateY();

        // updating coordinates of the top point of the bob

        BobTopPointX = BobTopPointFactor * pendulum.x;
        BobTopPointY = BobTopPointFactor * pendulum.y;

        // shifting the origin (0, 0) to (PivotPointX, PivotPointY), the pivot point from where the pendulum string has been hung

        pendulum.x = PivotPointX + pendulum.x;
        pendulum.y = PivotPointY + pendulum.y;

        BobTopPointX = PivotPointX + BobTopPointX;
        BobTopPointY = PivotPointY + BobTopPointY;

        /*
            " Canvas's origin is at top left corner "

            Canvas dimenions:- 
            
            full screen dimensions (with debug banner): 1366 x 768

            blank canvas dimensions (without debug banner): 1366 x 583

        */

        setState(() {});
      }
    );
  }

  @override
  void dispose() 
  {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    // the main 'build' method of the app

    return Scaffold
    (
        backgroundColor: Colors.black,
        appBar: AppBar
        (
          title: const Text('Flutter Physics Simulation App - simple pendulum'),
        ),
        body: InteractiveViewer
        (
          child: CustomPaint
          (
            painter: PendulumPainter(pendulum.x, pendulum.y, pendulum.radius, PivotPointX, PivotPointY, BobTopPointX, BobTopPointY),
            child: Container(),
          ),
        )
    );
  }
}

class PendulumPainter extends CustomPainter 
{
  final double x;
  final double y;
  final double radius;
  final double PivotPointX;
  final double PivotPointY;
  final double BobTopPointX;
  final double BobTopPointY;
  
  PendulumPainter(this.x, this.y, this.radius, this.PivotPointX, this.PivotPointY, this.BobTopPointX, this.BobTopPointY);  

  @override
  void paint(Canvas canvas, Size size)
  {
    Paint BobPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Paint StringPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;

    canvas.drawCircle(Offset(x, y), radius, BobPaint);

    canvas.drawLine(Offset(PivotPointX, PivotPointY), Offset(BobTopPointX, BobTopPointY), StringPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) 
  {
    return true;
  }
}

class PurplePageWaveParticleMotion extends StatefulWidget {
  const PurplePageWaveParticleMotion({super.key, required this.title});

  final String title;
  
  @override
  _PurplePageWaveParticleMotionState createState() => _PurplePageWaveParticleMotionState();
}

class _PurplePageWaveParticleMotionState extends State<PurplePageWaveParticleMotion> {
  double inputValue1 = 310;
  double inputValue2 = 400;
  double inputValue3 = 120;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 155, 97, 165),
      appBar: AppBar(
        title: Text(
          'Wave particle motion',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Wave particle motion',
              style: TextStyle(
                fontSize: 36,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        inputValue1 = double.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'input v',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 169, 233, 172),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 120,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        inputValue2 = double.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'input lambda',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 169, 233, 172),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 120,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        inputValue2 = double.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'input A',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 169, 233, 172),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform any action you want with inputValue1, inputValue2 and inputValue3
                Navigator.push(context,
                  // MaterialPageRoute(builder: (context) => HomePage(inputValue1, inputValue2)),
                  MaterialPageRoute(builder: (context) => SimulationPageWaveParticleMotion()),
                );

                //
                print('Value 1: $inputValue1, Value 2: $inputValue2, Value 3: $inputValue3');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Enter',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => HomePage(inputValue1, inputValue2)),
                  MaterialPageRoute(builder: (context) => SimulationPageWaveParticleMotion()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              child: Icon(
                Icons.play_arrow,
                size: 60,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TheoryPageWaveParticleMotion()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              child: Text(
          'Theory',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
            ),
          ],
        ),
      ),
    );
  }
}

class TheoryPageWaveParticleMotion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wave particle motion theory',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          "Wave particle motion" +
"\n\n-> Theory:" + 
"\nEvery particle of the wave is said to be in Simple Harmonic Motion (SHM) when the" +
"\nwave is travelling through/propagating through the medium." +

"\n\n-> Parameters:" +
"\n• v: velocity of the wave particle" +
"\• A: amplitude of the wave particle" +
"\n• ϕ: initial phase angle of the wave particle" +
"\n• t: time instant ‘t’" +
"\n• x(t): x-coordinate of the wave particle as a function of t" +
"\n• y(t): y-coordinate of the wave particle as a function of t" +

"\n\n-> Equations:" +
"\nx(t) = t" +
"\ny(t) = A.sin(k.x−ω.t + ϕ)"
,
          style: TextStyle(
            fontSize: 21,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SimulationPageWaveParticleMotion extends StatefulWidget
{
  // const HomePage({Key? key}) : super(key: key);

  const SimulationPageWaveParticleMotion({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<SimulationPageWaveParticleMotion> createState() => _SimulationPageWaveParticleMotionState();
}

class _SimulationPageWaveParticleMotionState extends State<SimulationPageWaveParticleMotion> 
{
  late Timer timer;

  late Stopwatch stopwatch;

  late WaveMotionParticle waveMotionParticle;

  late double radius;

  // origin shifting point

  final double StartingPointX = 250.0;
  final double StartingPointY = 300.0;

  @override
  void initState()
  {
    // v, lambda, A, phi, c1, c2 : take user inputs

    radius = 9;

    waveMotionParticle = WaveMotionParticle(310, 400, 120, 0, radius, 1, 0);

    // at t = 0

    waveMotionParticle.x = StartingPointX + waveMotionParticle.c2;

    waveMotionParticle.y = StartingPointY + (waveMotionParticle.A * math.sin((waveMotionParticle.k * waveMotionParticle.c2) + waveMotionParticle.phi));

    // These trigonometric functions use radians, not degrees!

    stopwatch = Stopwatch();

    stopwatch.start();

    update();

    super.initState();
  }

  void update()
  {
    // the main 'update' method and 'set state' method of the app

    timer = Timer.periodic
    (
      const Duration(milliseconds: 100), // milliseconds: 16
      (timer) 
      { 
        // updating 'x' and 'y' coordinates of the wave motion particle

        waveMotionParticle.updateX((stopwatch.elapsedMilliseconds) / 10);
        waveMotionParticle.updateY((stopwatch.elapsedMilliseconds) / 10);

        // shifting origin

        waveMotionParticle.x = StartingPointX + waveMotionParticle.x;
        waveMotionParticle.y = StartingPointY + waveMotionParticle.y;

        /*
            " Canvas's origin is at top left corner "

            Canvas dimenions:- 
            
            full screen dimensions (with debug banner): 1366 x 768

            blank canvas dimensions (without debug banner): 1366 x 583

        */

        setState(() {});
      }
    );
  }

  @override
  void dispose() 
  {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    // the main 'build' method of the app

    return Scaffold
    (
        backgroundColor: Colors.black,
        appBar: AppBar
        (
          title: const Text('Flutter Physics Simulation App - wave motion particle'),
        ),
        body: InteractiveViewer
        (
          child: CustomPaint
          (
            painter: WaveMotionParticlePainter(waveMotionParticle.x, waveMotionParticle.y, waveMotionParticle.radius),
            child: Container(),
          ),
        )
    );
  }
}

class WaveMotionParticlePainter extends CustomPainter
{
  final double x;
  final double y;
  final double radius;

  WaveMotionParticlePainter(this.x, this.y, this.radius);

  @override
  void paint(Canvas canvas, Size size)
  {
    Paint WaveMotionParticlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(Offset(x, y), radius, WaveMotionParticlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) 
  {
    return true;
  }
}

