import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _getFirebaseUser() => _auth.currentUser;

  UserEntity? getCurrentUser() {
    final firebaseUser = _getFirebaseUser();
    if (firebaseUser == null) return null;
    return _firebaseUserToEntity(firebaseUser);
  }

  Future<UserEntity?> loginWithEmail(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _firebaseUserToEntity(credential.user);
  }

  Future<void> sendOtp(String phoneNumber, Function(String) onCodeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw e.message ?? 'OTP sending failed';
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<UserEntity?> verifyOtpAndLogin(
      String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final userCredential = await _auth.signInWithCredential(credential);
    return _firebaseUserToEntity(userCredential.user);
  }

  Future<UserEntity?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return _firebaseUserToEntity(userCredential.user);
  }

  Future<UserEntity?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status != LoginStatus.success) return null;

    final OAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken!.token); // ✅ fixed
    final userCredential = await _auth.signInWithCredential(credential);
    return _firebaseUserToEntity(userCredential.user);
  }

  Future<UserEntity?> signUp({
    required String name,
    required String email,
    required String password,
    required String role,
    String? profileImageUrl,
    String? phoneNumber,
  }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user?.updateDisplayName(name);
    if (profileImageUrl != null) {
      await userCredential.user?.updatePhotoURL(profileImageUrl);
    }
    await userCredential.user?.reload();

    // TODO: Save role, phoneNumber etc. to Firestore
    // await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
    //   'name': name,
    //   'email': email,
    //   'phone': phoneNumber,
    //   'role': role,
    //   'photoUrl': profileImageUrl,
    //   'createdAt': FieldValue.serverTimestamp(),
    // });

    return _firebaseUserToEntity(userCredential.user);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
  }

  UserEntity? _firebaseUserToEntity(User? user) {
    if (user == null) return null;
    return UserEntity(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoURL,
      // role will be fetched from Firestore later
    );
  }
}