//import 'package:password_manager/password_manager.dart';
import "dart:io";
import "dart:convert";
import "package:encrypt/encrypt.dart";
import "dart:math";

final key = Key.fromUtf8("9mVN0qaWO5oWgcCSMmA5HRmvYY3Q0xSP");
final myIV = IV.allZerosOfLength(16);
final encrypter = Encrypter(AES(key));

void main() async {
  while (true) {
    print('1) Add Entry');
    print('2) List Entries');
    print('3) Update Entry');
    print('4) Remove Entry');
    print('5) Exit');
    stdout.write('Select an option: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        // add information
        await uiAddToFile();
        break;
      case '2':
        // list entries
        await uiAccessFileInformation();
        break;
      case '3':
        //update information
        await uiUpdateFileInformation();
        break;
      case '4':
        // remove
        await uiRemoveFileInformation();
        stdout.write("Press enter to continue"); stdin.readLineSync();
        clearConsole();
        break;
      case '5':
        print('Goodbye!');
        return;
      default:
        print('Invalid option, try again.');
        break;
    }
  }
}

Future<void> uiAddToFile() async {
  stdout.write("What is the service you're using: ");
  String? service = stdin.readLineSync();
  while (true) {
    stdout.write("Is $service correct, yes(1) no(2): ");
    String? correct = stdin.readLineSync();
    if (correct == '1' && service != null) {
      break;
    } else if (correct == '2') {
      stdout.write("What is the service you're using: ");
      service = stdin.readLineSync();
    } else {
      print("Invalid input, try again");
    }
  }
  clearConsole();
  print("Service using is $service");
  stdout.write("What is your username: ");
  String? username = stdin.readLineSync();
  while (true) {
    stdout.write("Is $username correct, yes(1) no(2): ");
    String? correct = stdin.readLineSync();
    if (correct == '1' && username != null) {
      break;
    } else if (correct == '2') {
      stdout.write("What is the username you're using: ");
      username = stdin.readLineSync();
    } else {
      print("Invalid input, try again");
    }
  }
  clearConsole();
  print("Service using is $service, username is $username");
  stdout.write("What is your password: ");
  String? password = stdin.readLineSync();
  while (true) {
    stdout.write("Is $password correct, yes(1) no(2): ");
    String? correct = stdin.readLineSync();
    if (correct == '1' && password != null) {
      break;
    } else if (correct == '2') {
      stdout.write("What is the password you're using: ");
      password = stdin.readLineSync();
    } else {
      print("Invalid input, try again");
    }
  }
  clearConsole();
  print(
    "Service using is $service, username is $username, password is $password",
  );
  await addToFile(service.toLowerCase(), username.trim(), password.trim());
  stdout.write("Press enter to continue");
  stdin.readLineSync();
  clearConsole();
}

Future<String> uiAccessFileInformation() async {
  stdout.write("What is the service you're using: ");
  String? service = stdin.readLineSync();
  while (true) {
    stdout.write("Is $service correct, yes(1) no(2): ");
    String? correct = stdin.readLineSync();
    if (correct == '1' && service != null) {
      break;
    } else if (correct == '2') {
      stdout.write("What is the service you're using: ");
      service = stdin.readLineSync();
    } else {
      print("Invalid input, try again");
    }
  }
  clearConsole();
  List<Map<String, dynamic>> allInformation = await accessFileInformation(
    service.toLowerCase(),
  );
  for (var i in allInformation) {
    print("Username: ${i["username"]}, Password: ${i["password"]}");
  }
  stdout.write("Press enter to continue");
  stdin.readLineSync();
  clearConsole();
  return service;
}

Future<void> uiUpdateFileInformation() async {
  stdout.write("What is the service you're using: ");
  String? service = stdin.readLineSync();
  while (true) {
    stdout.write("Is $service correct, yes(1) no(2): ");
    String? correct = stdin.readLineSync();
    if (correct == '1' && service != null) {
      break;
    } else if (correct == '2') {
      stdout.write("What is the service you're using: ");
      service = stdin.readLineSync();
    } else {
      print("Invalid input, try again");
    }
  }
  clearConsole();
  if (! await File("$service.json").exists()) { print("You don't have any information fot that service"); return; }
  List<Map<String, dynamic>> allInformation = await accessFileInformation(
    service.toLowerCase()
  );
  for (int i = 0; i < allInformation.length; i++) {
    print("#${i+1} Username: ${allInformation[i]["username"]}, Password: ${allInformation[i]["password"]}");
  }
  stdout.write("Which position do you want to replace by number: "); String? indexReplacing = stdin.readLineSync();
  while (true){
    stdout.write("Is #$indexReplacing correct, yes(1) no(2): "); String? correct = stdin.readLineSync();
    if (correct == '1' && indexReplacing != null && int.tryParse(indexReplacing) is int && 0 < int.parse(indexReplacing) && allInformation.length >= int.parse(indexReplacing)) { break;}
    else if (correct == '2') { stdout.write("Which set do you want to replace by number: "); indexReplacing = stdin.readLineSync();}
    else { print("Invalid input try again"); }
  }
  clearConsole();
  print("Service using is $service, placement in list = $indexReplacing");
  stdout.write("What is your username: ");
  String? username = stdin.readLineSync();
  while (true) {
    stdout.write("Is $username correct, yes(1) no(2): ");
    String? correct = stdin.readLineSync();
    if (correct == '1' && username != null) {
      break;
    } else if (correct == '2') {
      stdout.write("What is the username you're using: ");
      username = stdin.readLineSync();
    } else {
      print("Invalid input, try again");
    }
  }
  clearConsole();
  print("Service using is $service, placement in list = $indexReplacing, username is $username");
  stdout.write("What is your password: ");
  String? password = stdin.readLineSync();
  while (true) {
    stdout.write("Is $password correct, yes(1) no(2): ");
    String? correct = stdin.readLineSync();
    if (correct == '1' && password != null) {
      break;
    } else if (correct == '2') {
      stdout.write("What is the password you're using: ");
      password = stdin.readLineSync();
    } else {
      print("Invalid input, try again");
    }
  }
  clearConsole();
  print(
    "Service using is $service, placement in list = $indexReplacing, username is $username, password is $password",
  );
  await updateFileInformation(service.toLowerCase(),int.parse(indexReplacing)-1,username,password);
  print("New information for $service: ");
  allInformation = await accessFileInformation(service.toLowerCase());
  for (var i in allInformation) {
    print("Username: ${i["username"]}, Password: ${i["password"]}");
  }
  stdout.write("Press enter to continue"); stdin.readLineSync();
}

Future<void> uiRemoveFileInformation() async {
  stdout.write("What is the service you're using: ");
  String? service = stdin.readLineSync();
  while (true) {
    stdout.write("Is $service correct, yes(1) no(2): ");
    String? correct = stdin.readLineSync();
    if (correct == '1' && service != null) {
      break;
    } else if (correct == '2') {
      stdout.write("What is the service you're using: ");
      service = stdin.readLineSync();
    } else {
      print("Invalid input, try again");
    }
  }
  clearConsole();
  List<Map<String,dynamic>> allInformation = await accessFileInformation(service);
  if (allInformation.isEmpty) { return; }
  print("Service using is $service");
  for (int i = 0; i < allInformation.length; i++) {
    print("#${i+1} Username: ${allInformation[i]["username"]}, Password: ${allInformation[i]["password"]}");
  }
  stdout.write("Which position do you want to replace by number: "); String? indexRemoving = stdin.readLineSync();
  while (true){
    stdout.write("Is #$indexRemoving correct, yes(1) no(2): "); String? correct = stdin.readLineSync();
    if (correct == '1' && indexRemoving != null && int.tryParse(indexRemoving) is int && 0 < int.parse(indexRemoving) && allInformation.length >= int.parse(indexRemoving)) { break;}
    else if (correct == '2') { stdout.write("Which set do you want to replace by number: "); indexRemoving = stdin.readLineSync();}
    else { print("Invalid input try again"); }
  }
  clearConsole();
  stdout.write("Press 1 to confrim anything else to cancel: "); String? confirmation = stdin.readLineSync();
  if (confirmation != '1') { print("Terminating the removal process"); return; }
  await removeFileInformation(service, int.parse(indexRemoving)-1); 
  print("Information terminated");
}

Future<void> removeFileInformation(String fileName, int locatingInList) async {
  List<Map<String, dynamic>> currFileData = await accessFileInformation(
    fileName,
  );
  currFileData.removeAt(locatingInList);
  await File("$fileName.json").writeAsString(encryptor(currFileData, await accessIV(fileName)));
}

Future<void> updateFileInformation(String fileName,int locatingInList, String newUsername, String newPassword,) async {
  List<Map<String, dynamic>> currFileData = await accessFileInformation(fileName);
  currFileData.removeAt(locatingInList);
  currFileData.add({"username": newUsername, "password": newPassword});
  await File("$fileName.json").writeAsString(encryptor(currFileData, await accessIV(fileName)));
}

Future<void> addToFile(
  String fileName,
  String usernameNeededToAdd,
  String passwordNeededToAdd
) async {
  File file = File("$fileName.json");
  if (!await file.exists()) {
    await file.create(); await addNewIV(fileName);
  }
  List<Map<String, dynamic>> currFileData = await accessFileInformation(
    fileName
  );
  Map<String, dynamic> information = {
    "username": usernameNeededToAdd,
    "password": passwordNeededToAdd,
  };
  currFileData.add(information);
  await file.writeAsString(encryptor(currFileData,await accessIV(fileName)));
}
Future<IV> accessIV(String service) async {
  File file = File("keys.json");
  String raw = await file.readAsString();
  dynamic decoded = jsonDecode(decryptor(raw, myIV));
  Map<String,dynamic> loadedData = decoded as Map<String,dynamic>;
  Map<String,int> finalLoadedData = {};
  for (var i in loadedData.keys){
    finalLoadedData[i] = loadedData[i] as int;
  }
  return IV.allZerosOfLength(finalLoadedData[service]!);
}
Future<void> addNewIV(String service) async {
  File file = File("keys.json");
  String raw = await file.readAsString();
  Map<String,dynamic> decoded = jsonDecode(decryptor(raw, myIV));
  Map<String,int> loadedData = {};
  for (var i in decoded.keys){
    loadedData[i] = decoded[i];
  }
  loadedData[service] = Random().nextInt(16)+1;
  file.writeAsString(encryptor(loadedData, myIV));
}
Future<List<Map<String, dynamic>>> accessFileInformation(String fileName) async {
  File file = File("$fileName.json");
  if (!await file.exists()) {
    print("No information stored for this service");
    return [];
  }
  if (await file.length() <= 0) {
    return [];
  }

  String raw = await file.readAsString();
  List<dynamic> decoded = jsonDecode(decryptor(raw, await accessIV(fileName))); 
  List<Map<String, dynamic>> loadedData = decoded
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
  return loadedData;
}
String encryptor(dynamic information, IV iv) {
  String jsonString = jsonEncode(information);
  return encrypter.encrypt(jsonString,iv:iv).base64;
}
String decryptor(String jsonString, IV iv) {
  return encrypter.decrypt64(jsonString,iv:iv);
}
void clearConsole() {
  print("\r${"\n" * 100}");
}
