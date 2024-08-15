import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lesson_95/blocs/password_bloc.dart';
import 'package:lesson_95/blocs/password_event.dart';
import 'package:lesson_95/blocs/password_state.dart';
import 'package:lesson_95/ui/screens/home_screen.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150.0),
        child: Column(
          children: [
            const Gap(50),
            BlocBuilder<PasswordBloc, PasswordState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: index < state.pin.length
                              ? Colors.green
                              : Colors.white,
                          border: index >= state.pin.length
                              ? Border.all(
                                  color: const Color(0xff9AA0AA), width: 1)
                              : null,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(60),
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                ),
                itemBuilder: (context, index) {
                  index++; // increment to match the 1-12 grid setup

                  if (index == 10) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                      child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.fingerprint)),
                    );
                  }

                  if (index == 12) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        if (context.read<PasswordBloc>().state.pin.isNotEmpty) {
                          context.read<PasswordBloc>().add(RemoveDigit());
                        }
                      },
                      child: const Icon(
                        Icons.backspace_outlined,
                        size: 30,
                      ),
                    );
                  }

                  // Number buttons
                  return InkWell(
                    splashColor: Colors.green.shade100.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      context.read<PasswordBloc>().add(AddDigit(index));
                      if (context.read<PasswordBloc>().state.pin.length == 3) {
                        context.read<PasswordBloc>().add(SubmitPassword());

                        if (context.read<PasswordBloc>().state.isValid) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Homepage(),
                            ),
                          );
                        } else {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Incorrect Password')),
                          );
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        "$index",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
