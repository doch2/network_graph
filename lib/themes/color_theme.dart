part of network_graph;


const blueOne = Color(0xFF4966FF);
const blueTwo = Color(0xFF00C5FF);
const blueThree = Color(0xFF2C4A94);
const blueFour = Color(0xFF0038FF);
const blueFive = Color(0xFF0500FF);
const blueSix = Color(0xFF1564FF);

const purpleOne = Color(0xFFA954FF);
const purpleTwo = Color(0xFF9277FF);
const purpleThree = Color(0xFF5D5ADE);



List<LinearGradient> gradientList = [blueLinearGradientOne, blueLinearGradientTwo, blueLinearGradientThree, purpleLinearGradientOne, purpleLinearGradientTwo];
const blueLinearGradientOne = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [ blueOne, blueTwo ]);
const blueLinearGradientTwo = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [ blueThree, blueTwo ]);
const blueLinearGradientThree = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [ blueSix, purpleThree ]);

const purpleLinearGradientOne = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [ purpleOne, blueFour ]);
const purpleLinearGradientTwo = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [ purpleTwo, blueFive ]);