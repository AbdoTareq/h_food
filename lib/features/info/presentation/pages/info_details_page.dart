import 'package:flutter/foundation.dart';
import 'package:h_food/core/view/widgets/custom_dropdown_field.dart';
import 'package:h_food/core/view/widgets/valid_button.dart';
import 'package:h_food/export.dart';
import 'package:h_food/features/info/presentation/bloc/info_details_bloc.dart';
import 'package:h_food/features/info/presentation/bloc/info_details_event.dart';
import 'package:h_food/features/info/presentation/bloc/info_details_state.dart';

class InfoDetailsPage extends StatefulWidget {
  const InfoDetailsPage({super.key});

  @override
  State<InfoDetailsPage> createState() => _InfoDetailsPageState();
}

class _InfoDetailsPageState extends State<InfoDetailsPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final weightTextController = TextEditingController();
  final heightTextController = TextEditingController();
  final ageTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final isValid = ValueNotifier(false);

  @override
  void dispose() {
    weightTextController.dispose();
    heightTextController.dispose();
    ageTextController.dispose();
    genderTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFBFBFBColor,
      appBar: CustomAppBar(title: context.t.enterDetails),
      body: BlocProvider(
        create: (context) => sl<InfoDetailsBloc>(),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 56),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 32,
                children: [
                  CustomDropdownFormField<String>(
                    title: context.t.gender,
                    hint: context.t.chooseYourGender,
                    validator: (value) {
                      return value?.length != null ? null : context.t.required;
                    },
                    onChanged: (p0) => genderTextController.text = p0!,
                    items: [context.t.male, context.t.female],
                  ),
                  TextInput(
                    controller: weightTextController,
                    title: context.t.weight,
                    hint: context.t.enterYourWeight,
                    inputType: TextInputType.number,
                    suffixIcon: Text(context.t.kg,
                        style: Theme.of(context).textTheme.labelLarge),
                    validate: (value) =>
                        value!.length > 1 ? null : context.t.required,
                  ),
                  TextInput(
                    controller: heightTextController,
                    title: context.t.height,
                    hint: context.t.enterYourHeight,
                    inputType: TextInputType.number,
                    suffixIcon: Text(context.t.cm,
                        style: Theme.of(context).textTheme.labelLarge),
                    validate: (value) =>
                        value!.length > 1 ? null : context.t.required,
                  ),
                  TextInput(
                    controller: ageTextController,
                    title: context.t.age,
                    hint: context.t.enterYourAge,
                    inputType: TextInputType.number,
                    validate: (value) {
                      Future.delayed(Duration(milliseconds: 200)).then((_) =>
                          isValid.value =
                              weightTextController.text.isNotEmpty &&
                                  heightTextController.text.isNotEmpty &&
                                  ageTextController.text.isNotEmpty &&
                                  genderTextController.text.isNotEmpty);
                      if (value!.length > 1) {
                        return null;
                      } else {
                        return context.t.required;
                      }
                    },
                  ),
                  BlocConsumer<InfoDetailsBloc, InfoState>(
                    listener: (context, state) {
                      if (state is InfoError) {
                        showFailSnack(message: state.message);
                      }
                      if (state is InfoSuccess) {
                        Logger().i(state.calories);
                        context.pushNamed(Routes.createOrder,
                            extra: state.calories);
                      }
                    },
                    builder: (context, state) {
                      return ValidButton(
                        isValid: isValid,
                        text: context.t.next,
                        isLoading: state is InfoLoading,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            context.read<InfoDetailsBloc>().add(
                                  SaveInfoEvent(
                                    weight: weightTextController.text,
                                    height: heightTextController.text,
                                    age: ageTextController.text,
                                    gender: genderTextController.text,
                                  ),
                                );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
