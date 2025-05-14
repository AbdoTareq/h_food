import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:h_food/export.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  const CustomDropdownFormField({
    super.key,
    required this.validator,
    required this.onChanged,
    this.hint,
    this.title,
    required this.items,
    this.initialItem,
    this.padding,
  });
  final String? Function(T?) validator;
  final String? hint;
  final String? title;
  final List<T> items;
  final T? initialItem;
  final dynamic Function(T?)? onChanged;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: k474747Color),
          ),
          10.heightBox,
        ],
        CustomDropdown<T>(
          items: items,
          decoration: CustomDropdownDecoration(
            closedFillColor: kWhite,
            closedBorder: Border.all(color: kEAECF0Color),
            closedBorderRadius: BorderRadius.circular(12),
          ),
          hintBuilder: (context, _, item) => Text(
            hint ?? item.toString(),
            style: context.textTheme.bodyLarge?.copyWith(color: k959595Color),
          ),
          initialItem: initialItem,
          closedHeaderPadding: padding ?? const EdgeInsets.all(20),
          validateOnChange: true,
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
