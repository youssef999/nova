import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:flutter/material.dart';

class AddHospital extends StatefulWidget {
  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class Hospital {
  bool? isChecked;
  String title;
  String subtitle;

  Hospital(this.isChecked, this.title, this.subtitle);
}

class _AddHospitalState extends State<AddHospital> {
  List<Hospital> hospitals = [
    Hospital(true, 'Apple Hospital',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(true, 'Silver Soul Clinic',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(false, 'Rainbow Hospital',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(false, 'Jonathan Hospital',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(false, 'Lothal Hospital',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(true, 'Peter Johnson Hospital',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(true, 'Apple Hospital',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(true, 'Silver Soul Clinic',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(false, 'Rainbow Hospital',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(false, 'Jonathan Hospital',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(false, 'Lothal Hospital',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
    Hospital(true, 'Peter Johnson Hospital',
        'General Hospital' + '\n' + 'At Walter street, Wallington, New York'),
  ];
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.addHospital!,
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
                    hint: locale.searchHospital,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  color: Theme.of(context).dividerColor,
                  child: Text(
                    locale.selectHospitalsToAdd!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).disabledColor),
                  ),
                ),
                ListView.builder(
                    itemCount: hospitals.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 6),
                            leading: Checkbox(
                              activeColor: Theme.of(context).primaryColor,
                              value: hospitals[index].isChecked,
                              onChanged: (val) {
                                setState(() {
                                  hospitals[index].isChecked = val;
                                });
                              },
                            ),
                            title: Text(
                              hospitals[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 16,
                                      color: black2,
                                      fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              hospitals[index].subtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      height: 1.4,
                                      fontSize: 13.5,
                                      color: lightGreyColor),
                            ),
                          ),
                          Divider(
                            thickness: 6,
                          ),
                        ],
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
