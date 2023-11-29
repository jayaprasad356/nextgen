import 'package:nextgen/util/index.dart';


class BackLinearColor extends StatelessWidget {
  final Widget child;
  const BackLinearColor({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kBgLinear1,
                kBgLinear2,
                kBgLinear3,
                kBgLinear4,
              ]
          ),
      ),
      child: child,
    );
  }
}
