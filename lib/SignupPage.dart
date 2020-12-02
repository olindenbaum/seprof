import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:seprof/Vars.dart';

class SignupPage extends StatefulWidget {
  Function navigatorCallback;
  SignupPage({Key key, @required this.navigatorCallback}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  List<bool> stepState = [false, false, false, false, false, false];
  String _accountType;
  List<Step> steps;
  final formKey = new GlobalKey<FormState>();

  int currentStep = 0;
  bool complete = false;
  bool checkboxValue = false;

  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() {
            complete = true;
          });
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() {
      stepState[step - 1] = true;
      currentStep = step;
    });
  }

  void _buildSteps() {
    steps = [
      Step(
        title: const Text('New Account'),
        isActive: stepState[0],
        state: stepState[0] ? StepState.complete : StepState.indexed,
        content: Column(
          children: <Widget>[
            DropDownFormField(
              titleText: 'Select Account Type',
              hintText: 'Please choose one',
              value: _accountType,
              onSaved: (value) {
                setState(() {
                  _accountType = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  _accountType = value;
                });
              },
              dataSource: [
                {
                  "display": "Packer",
                  "value": "packer",
                },
                {
                  "display": "Driver",
                  "value": "driver",
                },
              ],
              textField: 'display',
              valueField: 'value',
            ),
          ],
        ),
      ),
      Step(
        isActive: stepState[1],
        state: stepState[1] ? StepState.complete : StepState.indexed,
        title: const Text('Information'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Surname'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            CheckboxListTile(
              value: checkboxValue,
              onChanged: (val) {
                setState(() => checkboxValue = val);
              },
              subtitle: !checkboxValue
                  ? Text(
                      'Required.',
                      style: TextStyle(color: Colors.red),
                    )
                  : null,
              title: new Text(
                'I agree to the terms and conditions.',
                style: TextStyle(fontSize: 14.0),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
      Step(
        isActive: stepState[2],
        state: stepState[2] ? StepState.complete : StepState.indexed,
        title: const Text('Additional'),
        content: Column(
          children: <Widget>[
            _accountType == "driver"
                ? RaisedButton(
                    color: driverTheme.primaryColor,
                    child: Text("Upload Drivers license"),
                    onPressed: () {},
                  )
                : Container(),
            (_accountType == "packer" || _accountType == "driver")
                ? RaisedButton(
                    color: driverTheme.primaryColor,
                    child: Text("Upload Passport"),
                    onPressed: () {})
                : Container(),
          ],
        ),
      ),
      Step(
        isActive: stepState[3],
        state: stepState[3] ? StepState.complete : StepState.indexed,
        title: const Text('Centre Code'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Centre Code'),
            ),
          ],
        ),
      ),
      Step(
        isActive: stepState[4],
        state: stepState[4] ? StepState.complete : StepState.indexed,
        title: const Text('Confirmation'),
        content: Column(
          children: <Widget>[
            Text("Check your emails for confirmation of approval.")
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _buildSteps();
    return Theme(
      data: driverTheme,
      child: Scaffold(
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                blurRadius: 3,
                offset: Offset(6, 2),
              ),
            ],
          ),
          child: RaisedButton(
            color: driverTheme.accentColor,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            child: Icon(Icons.arrow_forward),
            onPressed: () => widget.navigatorCallback(1, duration: 300),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: driverTheme.accentColor,
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stepper(
                  steps: steps,
                  currentStep: currentStep,
                  onStepContinue: next,
                  onStepTapped: (step) => goTo(step),
                  onStepCancel: cancel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
