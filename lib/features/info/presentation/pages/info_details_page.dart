import 'package:elm_task/export.dart';
import 'package:elm_task/features/info/presentation/bloc/auth_bloc.dart';
import 'package:elm_task/features/info/presentation/bloc/auth_event.dart';
import 'package:elm_task/features/info/presentation/bloc/auth_state.dart';

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
  String gender = 'male';

  @override
  void dispose() {
    weightTextController.dispose();
    heightTextController.dispose();
    ageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.t.login),
      body: BlocProvider(
        create: (context) => sl<AuthBloc>(),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 56),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 32,
                children: [
                  FlutterLogo(size: 300),
                  TextInput(
                    controller: weightTextController,
                    hint: context.t.email,
                    validate: (value) =>
                        isEmail(value) ? null : context.t.required,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthError) {
                        showFailSnack(message: state.message);
                      }
                      if (state is LoginSuccess) {
                        if (state.success) {
                          showSuccessSnack(message: context.t.success);
                          // context.pushNamed(
                          //   Routes.verify,
                          //   extra: weightTextController.text,
                          // );
                        } else {
                          showFailSnack(message: context.t.failed);
                        }
                      }
                    },
                    builder: (context, state) {
                      return RoundedCornerButton(
                        text: context.t.loginToYourAccount,
                        isLoading: state is AuthLoading,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  LoginEvent(weightTextController.text),
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
