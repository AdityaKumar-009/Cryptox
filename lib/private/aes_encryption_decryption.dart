import 'package:encrypt/encrypt.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AESService {
  Key fetchKey({required String? key});
  String doEncryption({String? words, String? privateKey, String? key});
  String doDecryption({String? key, Barcode? res});
  void saveKeyForBackup(
    String key,
    String? words,
    String? privateKey,
  );
  void saveQRForBackup(
    String encryptedVal,
    String? words,
    String? privateKey,
  );
}

class UseAES extends AESService {
  //
  @override
  void saveQRForBackup(
      String encryptedVal, String? words, String? privateKey) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (words != null) {
      try {
        sp.setString('encryptedWords', encryptedVal);
        print(
            '---------encryptedWords store successfully in shared preference!-----------');
      } catch (e) {
        print(
            '---------encryptedWords UNABLE to store in shared preference!-----------');
      }
    } else {
      try {
        sp.setString('encryptedPrivateKey', encryptedVal);
        print(
            '---------encryptedPrivateKey stored successfully! in shared preference!-----------');
      } catch (e) {
        print(
            '---------encryptedPrivateKey UNABLE to store in shared preference!-----------');
      }
    }
  }

  //
  @override
  void saveKeyForBackup(String key, String? words, String? privateKey) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (words != null) {
      try {
        sp.setString('QRWordsPassword', key);
        print(
            '--------- QRWordsPassword stored successfully! in shared preference! -----------');
      } catch (e) {
        print(
            '--------- QRWordsPassword UNABLE to store in shared preference! -----------');
      }
    } else {
      try {
        sp.setString('QRPrivatePassword', key);
        print(
            '--------- QRPrivatePassword stored successfully! in shared preference! -----------');
      } catch (e) {
        print(
            '--------- QRPrivatePassword UNABLE to store in shared preference! -----------');
      }
    }
  }

  // FOR RETURNING ACTUAL KEY : DEFAULT OR CUSTOM
  @override
  Key fetchKey({required String? key}) {
    String defaultKey = 'It is my Secret Key No One Knows'; //DEFAULT PASSWORD
    Key myFinalKey;
    if (key == null) {
      myFinalKey = Key.fromUtf8(defaultKey);
    } //It should of 16,32 character size to work, since key is of 128/256 bits but 1UTF8 character size is 4bits, means 32[char needed]*4 = 128bits
    else {
      print(
          'KEY IS -------------------> ${key} \t\t [LENGTH]----->${key.length}');
      String key32len = key; //CUSTOM PASSWORD

      // SAVING PASSWORD FOR BACKUP [  IN SETTINGS PAGE ]

      print(
          'MY 32 LENGTH KEY [BEFORE LOOP]-------------------> $key32len [LENGTH]----->${key32len.length}');
      for (int i = key.length; i < 32; i++) {
        key32len += '*';
      }
      print(
          'MY 32 LENGTH KEY [AFTER LOOP]-------------------> $key32len  [LENGTH]----->${key32len.length}');
      myFinalKey = Key.fromUtf8(key32len);
    }
    return myFinalKey;
  }

  // FOR ENCRYPTION USED IN QR CREATION PAGE
  // TODO -> USE THIS METHOD IN CLOUD EXPORT
  @override
  String doEncryption({String? words, String? privateKey, String? key}) {
    if (key != null) {
      saveKeyForBackup(key, words, privateKey);
    }
    final myKey = fetchKey(key: key);
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(myKey));

    Encrypted encrypted;
    if (words != null) {
      encrypted = encryptor.encrypt(words, iv: iv);
    } else {
      encrypted = encryptor.encrypt(privateKey!, iv: iv);
    }

    final decryptedVal = encryptor.decrypt(encrypted, iv: iv);
    final encryptedVal = encrypted.base64;

    print('ENCRYPTED VALUE ------------->  $encryptedVal');
    print('DECRYPTED VALUE ------------->  $decryptedVal');

    saveQRForBackup(encryptedVal, words, privateKey);
    return encryptedVal;
  }

  // FOR DECRYPTION USED IN SCANNER PAGE
  // TODO -> USE THIS METHOD IN CLOUD RESTORE
  @override
  String doDecryption({String? key, Barcode? res}) {
    final myKey = fetchKey(key: key);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(myKey));

    String? decryptedVal;
    if (res != null) {
      decryptedVal = encrypter.decrypt64(res.code.toString(), iv: iv);
    } else {
      // LOGIC FOR CLOUD DECRYPTION
      decryptedVal = '';
    }

    print('DECRYPTED VALUE ------------->  $decryptedVal');
    return decryptedVal;
  }
}
