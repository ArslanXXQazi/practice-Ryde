import 'package:practice_ryde/src/controllers/constants/linker.dart';

class LineContainer extends StatelessWidget {
  const LineContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Container(
      height: height*.001,
      width: width*1,
      color: Theme.of(context).colorScheme.tertiary,
    );
  }
}
