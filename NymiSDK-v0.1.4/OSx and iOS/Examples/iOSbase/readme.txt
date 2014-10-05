This package provides an Xcode project that implements basic use of NCL, allowing you to get from an unprovisioned Nymi to streaming ECG. The app is organized from top to bottom; the top third deals with unprovisioned Nymis, the middle with provisions (which should be viewed as bridges between this NED and a Nymi), and the bottom with provisioned Nymis. The very bottom provides a message log. The message log can be found in full in errorStream.txt with iTunes.

The file structure of the project is like so:
	libNCLiOS.a - the compiled NCL
	ncl.h - the NCL header
	messageLog.h and .mm - message logging source
	Xcode - files made by Xcode when a single-view iOS project is created, with unit tests taken out, and some files modified
		base
			ViewController.h and .mm
				-view controller that interacts with NCL
				-if you are using the emulator, you should change the IP address in the call to nclSetIpAndPort to the IP address of the computer on which you are running the emulator
			storyboards to allow the user to interact with the view controller
			base-Info.plist - one row added for "Application supports iTunes file sharing"
