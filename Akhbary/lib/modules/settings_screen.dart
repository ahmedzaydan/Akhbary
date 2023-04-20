import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit/news_cubit.dart';
import '../shared/cubit/news_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Dark mode",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Transform.scale(
                // to control the size of switch widget
                scale: 1.5,
                child: Switch(
                  activeColor: Colors.white,
                  activeTrackColor: Colors.blue,
                  inactiveThumbColor: Colors.blueGrey.shade600,
                  inactiveTrackColor: Colors.grey.shade400,
                  splashRadius: 50.0,
                  onChanged: (switchVal) {
                    NewsCubit.getNewsCubit(context).setSwitchValue();
                  },
                  value: NewsCubit.getNewsCubit(context).switchValue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
