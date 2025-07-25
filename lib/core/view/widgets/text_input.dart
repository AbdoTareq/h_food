import '../../../export.dart';

// TextField that takes TextEditingController from the main controller(ex:LoginController) to control text from outside to be independent widget
class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    this.focus,
    this.controller,
    this.function,
    required this.hint,
    this.spaceAfter = true,
    this.inputType,
    this.maxLength,
    this.registerFocus = false,
    this.isPass = false,
    this.onTap,
    this.disableInput = false,
    this.enabled = true,
    this.borderColor = kEAECF0Color,
    this.validate,
    this.suffixIcon,
    this.prefixIcon,
    this.fontSize,
    this.alignLabelWithHint = true,
    this.color,
    this.onChanged,
    this.textColor = kBlack,
    this.showUnderline = true,
    this.hintColor = kBlack,
    this.autofillHints,
    this.minLines,
    this.maxLines,
    this.contentPadding,
    this.cursorColor,
    required this.title,
  });

  final FocusNode? focus;
  final Function? function;
  final String hint;
  final String title;
  final bool spaceAfter;
  final TextInputType? inputType;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final Function(String value)? onChanged;
  final double? fontSize;
  final bool registerFocus;
  final bool? alignLabelWithHint;
  final bool isPass;
  final Function()? onTap;
  final bool disableInput;
  final bool enabled;
  final Color borderColor;
  final Color? cursorColor;
  final String? Function(String?)? validate;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? color;
  final Color? textColor;
  final Color? hintColor;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final bool showUnderline;
  final Iterable<String>? autofillHints;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title.toTitleCase(),
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: k474747Color),
        ),
        10.heightBox,
        TextFormField(
          autofillHints: widget.autofillHints,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus!.unfocus(),
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            alignLabelWithHint: false,
            // to hide maxLength counter
            counterText: '',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: widget.contentPadding ?? const EdgeInsets.all(20),
            errorStyle: const TextStyle(fontSize: 12, height: 0.8),
            filled: true,
            fillColor: kWhite,
            hintStyle:
                context.textTheme.bodyLarge?.copyWith(color: k959595Color),
            labelStyle:
                context.textTheme.bodyLarge?.copyWith(color: k959595Color),
            labelText: widget.hint.toTitleCase(),
            suffixIcon: widget.suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 40,
            ),
            prefixIcon: widget.prefixIcon,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 80,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: widget.borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: widget.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: widget.borderColor,
              ),
            ),
          ),
          onTap: widget.onTap,
          cursorColor: widget.cursorColor ?? widget.borderColor,
          onChanged: widget.onChanged,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          textInputAction: TextInputAction.next,
          autofocus: widget.registerFocus,
          enableInteractiveSelection: !widget.disableInput,
          enabled: widget.enabled,
          keyboardType: widget.inputType,
          obscureText: widget.isPass,
          inputFormatters: [
            if (widget.inputType == TextInputType.number)
              FilteringTextInputFormatter.allow(RegExp("[-0-9,.]")),
          ],
          readOnly: widget.disableInput,
          maxLength: widget.maxLength,
          onFieldSubmitted: (v) async {
            FocusScope.of(context).requestFocus(widget.focus);
            try {
              await widget.function!();
            } catch (e) {}
          },
          validator: widget.validate,
        ),
      ],
    );
  }
}
