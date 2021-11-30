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

## Distributing Passes:

***

After you have created a signed, compressed pass bundle, getting it into Wallet is easy. Mail and Safari support passes in iOS 6 and later and in macOS v10.8.2 and later, so you can use them to distribute passes by email or from a website. In iOS, they add passes to the pass library directly. In macOS, they use iCloud to add passes to the user’s iOS devices.

**To deliver a pass to the customer via email, simply send the signed pass as an attachment.**

>Mail and Safari expect passes to use the application/vnd.apple.pkpass MIME type. Configure your email creation system or web server to use this MIME type for pass data.

<br/>

## Designing passes:

***

You specify the pass style by providing the corresponding key at the top level of the  ``pass.json``  file:

-   Coupons use the key  ``coupon``. This pass style is appropriate for coupons, special offers, and other discounts.

-   Store cards use the key  ``storeCard``. This pass style is appropriate for store loyalty cards, discount cards, points cards, and gift cards. Typically, a store identifies an account the user has with your company that can be used to make payments or receive discounts. When the account carries a balance, show the current balance on the pass.

The value of the pass style key is a dictionary containing the fields that hold the pass content.

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

If you want to add secondary information you can use the field dictionaries ``secondaryFields`` , ``auxiliaryFields``, ``header`` and ``barcode``.  *As seen below.*

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

>Layout of a storeCard pass:

![StoreCard Pass](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/Art/store_card_2x.png)
