import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Auth/Verification/UI/verification_interator.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:flutter/material.dart';

class VerificationUI extends StatefulWidget {
  final VerificationInteractor verificationInteractor;

  @override
  _VerificationUIState createState() => _VerificationUIState();

  VerificationUI(this.verificationInteractor);
}

class _VerificationUIState extends State<VerificationUI> {
  final TextEditingController _controller = TextEditingController();
  int _counter = 20;
  late Timer _timer;

  _startTimer() {
    _counter = 20; //time counter
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    widget.verificationInteractor.verifyNumber();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.phoneVerification!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              locale.weveSentAnOTP!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).disabledColor, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            EntryField(
              controller: _controller,
              hint: locale.enter4digitOTP!.padLeft(24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            CustomButton(
              onTap: () {
                widget.verificationInteractor.verificationDone();
              },
              label: locale.submit,
            ),
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Text(
                  '0:${_counter.toString().padLeft(2, '0')} ' + "min left",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Spacer(
                  flex: 2,
                ),
                Expanded(
                  child: CustomButton(
                      label: locale.resend,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      textColor: Theme.of(context).hintColor,
                      padding: 0.0,
                      onTap: _counter < 1
                          ? () {
                              _startTimer();
                              widget.verificationInteractor.verifyNumber();
                            }
                          : null),
                ),
              ],
            ),
            SizedBox(
              height: 20,
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
