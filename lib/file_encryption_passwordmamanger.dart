import "dart:math";
extension MyStringExtensions on String{
  bool isPalindrome(){
    String lowerCase = toLowerCase();
    //print("${lowerCase.substring(0, lowerCase.length~/2 + 1)}${lowerCase.substring(lowerCase.length~/2, lowerCase.length).reverse()}");
    if (lowerCase.length == 1) { return true; }
    if (lowerCase.length % 2 == 0) { return lowerCase.substring(0, lowerCase.length~/2) == lowerCase.substring(lowerCase.length~/2, lowerCase.length).reverse(); }
    return lowerCase.substring(0, lowerCase.length~/2 + 1) == lowerCase.substring(lowerCase.length~/2, lowerCase.length).reverse();
  }
  String reverse() => split('').reversed.join('');
  String removeWhiteSpaces(){
    String newString = "";
    for (int i = 0; i < length; i++){
      if (substring(i,i+1) != " "){
        newString += substring(i,i+1);
      }
    }
    return newString;
  }
  bool similarToEmail() => contains("@") && contains(".");
}
extension MyListOfIntExtensions on List<int>{
  int sumOfList() { int newInt = 0; for (int i in this) {newInt += i; } return newInt;} 
}
extension MyIntExtensions on int{
  bool isPrime(){
    for (int i = 2; i <= sqrt(this).toInt(); i++){ if (this ~/~ i == this / i && i != this) { return false; } }  
    return true;
  }
  int factorial(){
    if (this == 0) { return 1;}
    int newInt = this; 
    for (int i = 1; i < this; i++){ newInt *= i; }
    return newInt;
  }
  bool multipleOf(int num) => this ~/ num == this / num;
  List<int> factors() => [for (int i = 1; i <= this; i++) if (this ~/ i == this / i) i];
  bool isPerfect() => (factors().sublist(0,factors().length-1)).sumOfList() == this;
  bool isSquare() => sqrt(this).toInt() == sqrt(this);
  int gcd(int other){
    for (int i = min(this,other); i > 1; i--){
      if (this / i is int &&  other / i is int) { return i; }
    }
    return 1;
  }
}
int calculate() {
  return 6 * 7;
}