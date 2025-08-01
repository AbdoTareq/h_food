import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  final List<Widget>? actions;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title.toTitleCase(),
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(fontFamily: GoogleFonts.poppins().fontFamily),
      ),
      actions: actions,
      backgroundColor: kWhite,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: SvgPicture.asset('assets/images/back.svg'),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
