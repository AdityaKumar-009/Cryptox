import 'package:encrypt/encrypt.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

abstract class AESService {
  Key fetchKey({required String? key});
  String doEncryption({String? words, String? privateKey, String? key});
  String doDecryption({String? key, Barcode? res});
}

class UseAES extends AESService {
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
      print(
          'MY 32 LENGTH KEY [BEFORE LOOP]-------------------> ${key32len} [LENGTH]----->${key32len.length}');
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
  // USE THIS METHOD IN CLOUD EXPORT
  @override
  String doEncryption({String? words, String? privateKey, String? key}) {
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

    return encryptedVal;
  }

  // FOR DECRYPTION USED IN SCANNER PAGE
  // USE THIS METHOD IN CLOUD RESTORE
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
