# CryptoX: Crypto-Currency Wallet App

CryptoX is a Flutter-based cryptocurrency wallet app that offers a secure and intuitive platform for providing features that existing apps like MetaMask, coinbase etc. doesn't provide.

---

## Features

1. **Wallet Creation and Import:**
    - Users can create a new wallet or import an existing one.
    - Creation includes generating a 12-word seed for the wallet.

2. **QR Code Functionality:**
    - Generates QR codes containing the 12-word mnemonic seed.
    - Provides an option to encrypt the QR code with a defined key or string password.

3. **Seed Import with Password:**
    - Allows users to scan encrypted QR codes.
    - Upon scanning, prompts the user to enter the password to decrypt and import the seed successfully.

4. **User Interface (UI):**
    - Offers an intuitive and user-friendly interface for a smooth user experience.

---

## Functionality Details

### Wallet Creation and Import

The app provides a seamless process for users to either create a new wallet or import an existing one. When creating a new wallet, it generates a 12-word seed for the user.

### QR Code Generation and Encryption

Users can generate QR codes containing their 12-word mnemonic seed. Additionally, the app allows users to encrypt these QR codes using a defined key or string password. This enhances the security of the seed when sharing the QR code.

### Seed Import and Decryption

The app supports scanning encrypted QR codes. Upon scanning, a dialog prompts the user to enter the password associated with the encrypted QR code. On successful decryption, the seed is imported securely into the app.

### Intuitive User Interface

CryptoX boasts an easy-to-navigate and intuitive UI, ensuring a pleasant experience for users interacting with their crypto wallets.

---

## Future Scopes

1. **Cloud Backup Integration:**
    - Future updates could include cloud backup features like integration with Google Drive or Firebase. This would provide users with an option to securely back up their wallet data.

2. **Real Crypto Implementation:**
    - In future releases, the app could expand its functionality to support real cryptocurrency transactions, enhancing its utility and value to users.
