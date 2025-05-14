import 'package:h_food/export.dart';

class ValidButton extends StatelessWidget {
  const ValidButton({
    super.key,
    required this.isValid,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  final ValueNotifier<bool> isValid;
  final String text;
  final bool isLoading;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isValid,
      builder: (context, value, child) {
        return RoundedCornerButton(
          isLoading: isLoading,
          isOutlined: !isValid.value,
          onPressed: isValid.value ? onPressed : null,
          text: text,
        );
      },
    );
  }
}
