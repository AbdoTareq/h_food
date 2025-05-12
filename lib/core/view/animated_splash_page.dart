import '../../../export.dart';

late String _homePath;
late int _duration;

enum AnimatedSplashType { StaticDuration, BackgroundProcess }

class AnimatedSplash extends StatefulWidget {
  AnimatedSplash(
      {super.key,
      required String title,
      required String home,
      Function? customFunction,
      required int duration,
      required AnimatedSplashType type,
      Map<dynamic, Widget>? outputAndHome}) {
    _homePath = home;
    _duration = duration;
  }

  @override
  AnimatedSplashState createState() => AnimatedSplashState();
}

class AnimatedSplashState extends State<AnimatedSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if (_duration < 1000) _duration = 2000;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => context.goNamed(_homePath),
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'assets/images/splash.png',
            width: 1.sw,
            height: 1.sh,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
