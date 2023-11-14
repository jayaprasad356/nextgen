import 'package:nextgen/util/index.dart';

class DefaultBack extends StatelessWidget {
  final Widget child;
  const DefaultBack({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width, // Set width to the screen width
      height:
          size.height, // Set height to the screen height
      decoration: const BoxDecoration(
          color: kBgColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.RADIUS_EXTRA2_LARGE),
              topLeft: Radius.circular(Dimensions.RADIUS_EXTRA2_LARGE))),
      padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_LARGE,
          right: Dimensions.PADDING_SIZE_LARGE,
          left: Dimensions.PADDING_SIZE_LARGE),

      child: child,
    );
  }
}
