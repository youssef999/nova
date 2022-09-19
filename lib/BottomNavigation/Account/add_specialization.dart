import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:flutter/material.dart';

class AddSpecialization extends StatefulWidget {
  @override
  _AddSpecializationState createState() => _AddSpecializationState();
}

class Specialization {
  bool? isChecked;

  Specialization(this.isChecked);
}

class _AddSpecializationState extends State<AddSpecialization> {
  List<Specialization> specializations = [
    Specialization(true),
    Specialization(true),
    Specialization(false),
    Specialization(false),
    Specialization(false),
    Specialization(true),
    Specialization(true),
    Specialization(false),
    Specialization(true),
    Specialization(true),
    Specialization(true),
    Specialization(false),
    Specialization(false),
    Specialization(false),
    Specialization(true),
    Specialization(true),
    Specialization(false),
    Specialization(true),
  ];
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<String?> specializationTitle = [
      locale.ser1,
      locale.ser2,
      locale.ser3,
      locale.ser4,
      locale.ser5,
      locale.ser6,
      locale.ser7,
      locale.ser8,
      locale.ser9,
      locale.ser1,
      locale.ser2,
      locale.ser3,
      locale.ser4,
      locale.ser5,
      locale.ser6,
      locale.ser7,
      locale.ser8,
      locale.ser9,
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.addSpecialization!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12),
                  child: EntryField(
                    color2: Color(0xffcecece),
                    prefixIcon: Icons.search,
                    hint: locale.searchSpecialization,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  color: Theme.of(context).dividerColor,
                  child: Text(
                    locale.selectSpecializationToAdd!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).disabledColor),
                  ),
                ),
                ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    itemCount: specializations.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                        leading: Checkbox(
                          activeColor: Theme.of(context).primaryColor,
                          value: specializations[index].isChecked,
                          onChanged: (val) {
                            setState(() {
                              specializations[index].isChecked = val;
                            });
                          },
                        ),
                        title: Text(
                          specializationTitle[index]!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 16,
                                  color: black2,
                                  fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: () {
                  Navigator.pop(context);
                },
                label: locale.save,
                radius: 0,
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
