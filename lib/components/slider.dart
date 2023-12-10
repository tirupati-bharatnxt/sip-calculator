import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final Function(double) onSliderValueChanged;
  final double sliderValue;
  const SliderWidget({super.key, required this.sliderValue, required this.onSliderValueChanged});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class  _SliderWidgetState extends State<SliderWidget> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    _sliderValue = widget.sliderValue;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Slider(
          value: _sliderValue,
          min: 0,
          max: 100,
          onChanged: (newValue) {
            setState(() {
              _sliderValue = newValue;
              widget.onSliderValueChanged(_sliderValue); // Notify the parent widget
              // _intValue = _sliderValue.toInt(); // Get integer value from slider
            });
          },
        ),
      ],
    );
  }
}
