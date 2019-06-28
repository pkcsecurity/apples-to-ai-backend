import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserBloc {
  static final UserBloc instance = UserBloc._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  factory UserBloc() {
    return instance;
  }

  UserBloc._internal();

  createUserWithEmailAndPassword(String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    // (await _auth.currentUser()).updateProfile(userUpdateInfo);
    print(user);
    return user;
  }

  loginWithPhoneNumber(String number) async {
    final user = await _auth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: Duration(minutes: 5),
        verificationCompleted: (AuthCredential auth) {print('Got some auth credentials $auth');},
        verificationFailed: (AuthException ex) {print('Got an auth exception $ex');},
        codeSent: (String s, [int i]) {print('Sent the code $s - $i');},
        codeAutoRetrievalTimeout: (String s ) {print('Auto Retrieval timeout $s');});
    return user;
  }

  Future<FirebaseUser> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user;
  }
}