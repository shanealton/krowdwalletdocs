# Krowd Apple Wallet: Create a Pass

> This is documentation for setting up and editing passes for Apple     
> Wallet.

<br/>

## Create a new pass package:

***

**To create a pass package for your new pass, do the following:**

1.  Make a new directory in the Documents folder called pass-name.pass. Using the .pass extension is a best practice, showing that the directory is a pass package.  

2.  Open the Pass-Framework.pass directory and copy/paste the default file structure to the new .pass directory to setup the framework for the new pass.

<br/>

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

<br/>

## **Signing and Compressing the Pass:**

***

To sign and compress the pass, use the signpass tool to sign the pass package. In Terminal, run the following commands:

``cd ~/Documents``  
``./signpass -p pass-name.pass``

These commands create a signed and compressed pass named pass-name.pkpass in the Documents folder. If the signpass command fails, make sure you are using your correct pass type identifier and check that the pass.json file contains valid JSON.

**You now have to signed and compressed pass inside of your Documents directory. It will have an extension of** ``.pkpass``.

<br/>

## Designing passes (Pass styles):

***

You specify the pass style by providing the corresponding key at the top level of the  ``pass.json``  file:

-   Coupons use the key  ``coupon``. This pass style is appropriate for coupons, special offers, and other discounts.

-   Store cards use the key  ``storeCard``. This pass style is appropriate for store loyalty cards, discount cards, points cards, and gift cards. Typically, a store identifies an account the user has with your company that can be used to make payments or receive discounts. When the account carries a balance, show the current balance on the pass.

The value of the pass style key is a dictionary containing the fields that hold the pass content.

<br/>

The pass style determines the maximum number of fields that can appear on the front of a pass:

In general, a pass can have up to three header fields, a single primary field, up to four secondary fields, and up to four auxiliary fields.

``coupons``, ``storeCard``, and ``generic`` passes with a square barcode can have a total of up to four secondary and auxiliary fields, combined.

The number of fields displayed on the pass also depends on the length of the text in each field. If there is too much text, some fields may not be displayed.

<br/>

### Coupons:

***

You can declare the values you would like to display on the coupon as an object  inside of the ``coupon`` key in your ``pass.json`` file.

```
	"coupon" : {
		"primaryFields" : [{
			"key" : "offer",
			"label" : "One free item.",
			"value" : "100% off"
		}]
	}
```

If you want to add secondary information you can use the field dictionaries ``secondaryFields`` , ``auxiliaryFields`` and ``barcode``.  *As seen below.*

If you need to show information on the back of the pass, these fields have a sibling called ``backFields``.

```
	"coupon" : {
		"primaryFields" : [{
			"key" : "offer",
			"label" : "One free item.",
			"value" : "100% off"
		}],
		"secondaryFields" : [{
			"key" : "",
			"label" : "",
			"value" : ""
		}],
		"auxiliaryFields" : [{
			"key" : "",
			"label" : "",
			"value" : ""
		}]
	}
```

<br/>

> Layout of a coupon pass:

![Coupon Pass](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Art/coupon_2x.png)

<br/>

### Store Cards:

---

You can declare the values you would like to display on the loyalty card as an object inside of the ``storeCard`` key in your ``pass.json`` file.

```
	"storeCard" : {
		"primaryFields" : [{
			"key" : "name",
			"label" : "Name",
			"value" : "Shane Alton"
		}]
	}
```

<br/>

>Layout of a storeCard pass:

![StoreCard Pass](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Art/store_card_2x.png)

<br/>

## Distributing Passes:

***

After you have created a signed, compressed pass bundle, getting it into Wallet is easy. Mail and Safari support passes in iOS 6 and later and in macOS v10.8.2 and later, so you can use them to distribute passes by email or from a website. In iOS, they add passes to the pass library directly. In macOS, they use iCloud to add passes to the user’s iOS devices.

<br/>

### Distribute using Email:

***

**To deliver a pass to the customer via email, simply send the signed pass as an attachment.**

>Mail and Safari expect passes to use the application/vnd.apple.pkpass MIME type. Configure your email creation system or web server to use this MIME type for pass data.

<br/>

## Distribute using Web Service API:

***

### Using the Web Service API:

This is a demo implementation for the Passbook web service api.
This document is broken up into three main sections:
 - How to get setup with this implementation
 - Sending push notifications

### Getting Started
You will need a handful of external resources to get this demo up and running.

# Certificate
Download or create your **Pass Type ID** certificate inside of your Apple Developer Account.

After adding this certificate to your keychain, open the keychain access application, navigate to **'My Certificates'**, click on the arrow next to your certificate and export both the certificate and key as a .p12 file.

Place the newly exported p.12 file inside of ``data/Certificate/anythingYouWant.p12``. Make sure to remember the password you choose as it will be needed when signing new passes.

# Hostname
Before we setup a production environment, your server and devices will need to be on the same network. The server
will need a static IP, domain name or Bonjour name.

# Xcode
Xcode and the Xcode Command Line Tools are both required to compile
the ruby gems listed in the next section.

[Download Xcode](https://apps.apple.com/us/app/xcode/id497799835?mt=12)
[Install Xcode Command Line Tools](https://macpaw.com/how-to/install-command-line-tools)

# Gems
This demo depends on the following external gems:
 - sinatra
 - rack
 - sequel
 - sqlite3
 - yaml
 - json
 - sign_pass
 - rubyzip

Use the following commands to install the gems
``$> sudo gem install sinatra sequel sqlite3 rubyzip rack yaml json terminal-table``

Make sure you are in the pass_server directory before running the following command.
``$> sudo gem install lib/sign_pass-0.1.7.gem``

# Setting up the reference server

For now, the setup of the server is hardcoded. In production you will enter the hostname and passtypeID when setting up the new server.

The reference server setup script will guide you through setting up the reference server.
Please have handy your hostname and the passTypeIdentifier of your pass.
To run the script type:

``$> lib/pass_server_ctl -s``

This will create the database file, the tables needed.

# Starting the server
To start the server run the following command from inside the root folder of the demo:

``$> rackup -p 4567``

# Initially Downloading the pass
The pass can be initially downloaded from the following URL on a device or from a
computer and emailed to a device. Note that this url does not conform to the API and lack  
security and authentication controls. This URL is for development purposes only.

http://localhost:4567/pass.pkpass

As you create new users and passes they will be placed in directories inside of /pass_server/data/passes

``$> lib/pass_server_ctl -a serial_number,authentication_token,pass_type_id``

### Sending push notifications
A push notification script is included in the lid directory. Use the curl commands below to
register a device then run the script with the following command, note that you will be prompted
for your certificate's password.

``$> lib/pass_server_ctl -n``

This will use the database and send out push notifications to the devices for all registrations in the database.
