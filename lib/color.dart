hexColor(String color) {
  var newColor = '0xff' + color;
  newColor = newColor.replaceAll('#', '');
  int intColor = int.parse(newColor);
  return intColor;
}