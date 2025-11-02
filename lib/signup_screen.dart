import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String? role = '';
  /* */ List<String> orgNames = []; /* */
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  bool isLoading = true;
  String? valueOrg;
  String name = '';
  String error = '';


  Future<String> getSmsCodeFromUser() async {
    String sms = '';
    await showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: Text('Enter sms code'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'sms'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                //Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                sms = controller.text;
                //Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
    return sms;
  }

  Future<bool> twofactor () async {
    bool twoFactorFailed = false;
    final user = FirebaseAuth.instance.currentUser!;
    final session = await user.multiFactor.getSession();
    final auth = FirebaseAuth.instance;
    String completePhoneNum = '+1${phoneController.text.trim()}';
    await auth.verifyPhoneNumber(
      multiFactorSession: session,
      phoneNumber: completePhoneNum,
      verificationCompleted: (_) {},
      verificationFailed: (_) {},
      codeSent: (String verificationId, int? resendToken) async {
        // See `firebase_auth` example app for a method of retrieving user's sms code:
        // https://github.com/firebase/flutterfire/blob/main/packages/firebase_auth/firebase_auth/example/lib/auth.dart#L591
        final smsCode = await getSmsCodeFromUser();

        if (smsCode != "") {
          // Create a PhoneAuthCredential with the code
          final credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );

          try {
            await user.multiFactor.enroll(
              PhoneMultiFactorGenerator.getAssertion(
                credential,
              ),
            );
          } on FirebaseAuthException catch (e) {
            print(e.message);
            twoFactorFailed = true;
          }
        }else{
          twoFactorFailed = true;
        }
      },
      codeAutoRetrievalTimeout: (_) {},
    );
    return twoFactorFailed;
  }

  Future<bool> sendSignInLinkToEmail() async{
    var acs = ActionCodeSettings(
      // URL you want to redirect back to. The domain (www.example.com) for this
      // URL must be whitelisted in the Firebase Console.
        url: 'rmhconnect-a5adb.firebaseapp.com',
        // This must be true
        handleCodeInApp: true,
        iOSBundleId: 'com.example.ios',
        androidPackageName: 'com.example.android',
        // installIfNotAvailable
        androidInstallApp: true,
        // minimumVersion
        androidMinimumVersion: '12');

    var emailAuth = _emailController.text.trim();
    bool emailAuthBool = false;
    FirebaseAuth.instance.sendSignInLinkToEmail(
        email: emailAuth, actionCodeSettings: acs)
        .catchError((onError) {
          emailAuthBool = false;
        })
        .then((value) {
          emailAuthBool = true;
        });
    return emailAuthBool;
  }

  @override
  void initState(){
    super.initState();
    loadOrgNames();
  }

  Future<void> loadOrgNames() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('organizations').get();
    final names = snapshot.docs
        .map((doc) => doc.data()['name'] as String?)
        .whereType<String>()
        .toList();

    setState(() {
      orgNames = names;
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: backgroundColor
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: isLoading ?
            Center(child: const CircularProgressIndicator()) :
            Form(
              key: _formKey,
              child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                  child: Text(
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 32
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 0),
                  child: Text(
                      "We are excited to have you!",
                      style: TextStyle(
                          fontSize: 24
                      )
                  ),
                ),
                TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: 'Name'
                    ),
                    validator: (String? name) {
                      if (name == null || name.isEmpty) {
                        return 'Please enter a screen name';
                      }
                      return null;
                    },
                    onChanged: (val) => setState(() => name = val)
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email'
                  ),
                  validator: (String? email) {
                    if (email == null || email.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => email = val)
                ),
                SizedBox(height: 20),
                TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        labelText: 'Phone'
                    ),
                    validator: (String? phone) {
                      if (phone == null || phone.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    onChanged: (val) => setState(() => email = val)
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password'
                  ),
                  obscureText: true,
                  validator: (String? password) {
                    if (password == null || password.length < 8) {
                      return 'Please enter a password with at least 8 characters.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm password'
                  ),
                  obscureText: true,
                  validator: (String? password) {
                    if (password != _passwordController.text) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => password = val)
                ),

                SizedBox(
                  height: 35
                ),
                DropdownSearch<String>(
                  decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                      labelText: 'Choose a Charity'
                    )
                  ),
                  items: (f, cs) => orgNames,
                    popupProps: PopupProps.menu(
                    fit: FlexFit.loose
                    ),
                    selectedItem: valueOrg,
                    validator: (String? valueOrg) {
                      if (valueOrg == null || valueOrg.isEmpty) {
                      return 'Please select your location';
                      }
                      return null;
                      },
                        onChanged: (val) => setState(() => valueOrg = val)
                  ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            error = '';
                          });
                          try{
                            if (! (await sendSignInLinkToEmail())){
                              throw Exception;
                            }
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            //bool twoFactorFailed = await twofactor();
                            // if(twoFactorFailed){
                            //   User? user = FirebaseAuth.instance.currentUser;
                            //   if (user != null) {
                            //     try {
                            //       await user.delete();
                            //     }catch(e){
                            //       print("Error: $e");
                            //     }
                            //   }
                            //   return;
                            // }
                            final roleDoc = await FirebaseFirestore.instance
                              .collection('admins')
                              .where('email', isEqualTo: email)
                              .limit(1)
                              .get();
                            role = (roleDoc.docs.isNotEmpty) ? 'admin': 'user';
                            await FirebaseFirestore.instance
                              .collection('users')
                              .doc(credential.user!.uid)
                              .set({
                                'email': email,
                                'role': role,
                                'location': valueOrg,
                                'name': name,
                              });
                            if (role == 'admin') {
                              Navigator.pushReplacementNamed(context, '/admin_navigation');
                            }
                            else {
                              Navigator.pushReplacementNamed(context, '/navigation_screen');
                            }
                          }
                          catch(e) {
                            setState(() { error = e.toString(); });
                          }
                        }
                      },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue
                    ),
                      child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Not your first time? Log in!",
                          style: TextStyle(
                            color: Colors.blue
                          )
                      )
                  )
                ),
                if (error.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(error, style: TextStyle(color: Colors.red)),
                ],
              ],
            ),
          )
        ),
      )
    );
  }
}
