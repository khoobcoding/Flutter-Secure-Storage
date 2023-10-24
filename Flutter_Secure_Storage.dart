// Make sure minSdkversion is above 18 ( in build.gradle)

dependencies:
  flutter_secure_storage: ^9.0.0  // Add this package 
    
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorageApp extends StatefulWidget {
  const SecuredStorageApp({super.key});

  @override
  State<SecuredStorageApp> createState() => _SecuredStorageAppState();
}

class _SecuredStorageAppState extends State<SecuredStorageApp> {
  TextEditingController usernametextcontroller = TextEditingController();
  TextEditingController passwordtextcontroller = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? usernamedata='';
  String? passworddata='';

  write(String key, String value) async {
    await storage.write(key: key, value: value);
  }
   read(String key) async {
    final data = await storage.read(key: key) ?? 'No Data';
    return data;
  }
  readall()async{
    final data = await storage.readAll();
    return data;
  }
  delete(String key)async{
    await storage.delete(key: key);
    setState(() {
      
    });
  }
  deleteall()async{
    await storage.deleteAll();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text('Flutter Secure Storage',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 220, 220, 220),
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin: const EdgeInsets.all(5),
                width: 250,
                child: TextField(
                  controller: usernametextcontroller,
                  decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Username'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 220, 220, 220),
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin: const EdgeInsets.all(15),
                width: 250,
                child: TextField(
                  controller: passwordtextcontroller,
                  decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Password'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
               Text(
                usernamedata!,
                style: const TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 75, 75, 75),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
               Text(
                passworddata!,
                style: const TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 75, 75, 75),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 255, 23, 23),
                      ),
                      fixedSize: MaterialStatePropertyAll(Size(250, 40))),
                  onPressed: () {
                    write('username', usernametextcontroller.text.toString());
                    write('password', passwordtextcontroller.text.toString());
                  },
                  child: const Text(
                    'Write Data',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 1, 189, 139),
                      ),
                      fixedSize: MaterialStatePropertyAll(Size(250, 40))),
                  onPressed: () async{
                   usernamedata= await read('username');
                   passworddata= await read('password');
                   print(await readall());
                   setState(() {
                     
                   });
                   print(usernamedata);
                   print(passworddata);
                  },
                  child: const Text(
                    'Read Data',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.blue,
                      ),
                      fixedSize: MaterialStatePropertyAll(Size(250, 40))),
                  onPressed: () async{
                    // await delete('username');
                    // await delete('password');
                    await deleteall();
                    print('Username Data');
                    print(await storage.containsKey(key: 'username'));
                    print('Password Data');
                    print(await storage.containsKey(key: 'password'));
                    print('Data Deleted');
                  },
                  child: const Text(
                    'Delete Data',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
