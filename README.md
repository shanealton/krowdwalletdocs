# Krowd Apple Wallet: Create a Pass

> This is documentation for setting up and editing passes for Apple     
> Wallet.

## Create a new pass package:

***

**To create a pass package for your new pass, do the following:**

1.  Make a new directory in the Documents folder called pass-name.pass. Using the .pass extension is a best practice, showing that the directory is a pass package.  

2.  Open the Pass-Framework.pass directory and copy/paste the default file structure to the new .pass directory to setup the framework for the new pass.

## **Setting the Pass Type Identifier and Team ID:**

***

Every pass has a pass type identifier associated with a developer account. Pass type identifiers are managed in Member Center by a team admin.

**To register a pass type identifier, do the following:**

1.  In your Apple Developer account, navigate to [Certificates, Identifiers & Profiles](http://developer.apple.com/account), select Identifiers.  

2.  Under Identifiers, select Pass Type IDs.  

3.  Click the plus (+) button.  

4.  Enter the description and pass type identifier, and click Submit.

> If you are setting up for the first time you may need to add your
> certificate to finish the process. You can acquire a certificate for
> your machine like this:
> [https://help.apple.com/developer-account/#/devbfa00fef7](https://help.apple.com/developer-account/#/devbfa00fef7).
> Drag and drop certificate onto the page and finish the process.



**To find your Team ID, do the following:**

1.  Open Keychain Access, and select your certificate.  

2.  Select File > Get Info, and find the Organizational Unit section under Details. This is your Team ID.  
    The pass type identifier appears in the certificate under the User ID section.

## **Signing and Compressing the Pass:**

***

To sign and compress the pass, use the signpass tool to sign the pass package. In Terminal, run the following commands:

``cd ~/Documents``  
``./signpass -p pass-name.pass``

These commands create a signed and compressed pass named pass-name.pkpass in the Documents folder. If the signpass command fails, make sure you are using your correct pass type identifier and check that the pass.json file contains valid JSON.

**You now have to signed and compressed pass inside of your Documents directory. It will have an extension of** ``.pkpass``.

## Distributing Passes:

***

After you have created a signed, compressed pass bundle, getting it into Wallet is easy. Mail and Safari support passes in iOS 6 and later and in macOS v10.8.2 and later, so you can use them to distribute passes by email or from a website. In iOS, they add passes to the pass library directly. In macOS, they use iCloud to add passes to the user’s iOS devices.

**To deliver a pass to the customer via email, simply send the signed pass as an attachment.**

>Mail and Safari expect passes to use the application/vnd.apple.pkpass MIME type. Configure your email creation system or web server to use this MIME type for pass data.
