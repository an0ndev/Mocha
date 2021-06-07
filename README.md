# Mocha
:coffee: Keep your MacBook awake, even when the lid closes! This application is inspired by the classic Caffeine app, is tested on macOS Catalina, and only requires administrator authorization once to install the app.

A special thanks goes out to my G Maddox Morris for the idea, and also to the awesome math teacher Mr. P for trusting me enough to let me test it on the school MacBooks.

## Building from source
Run the following in a Terminal:
1. (If the developer tools, which come with Xcode, are not installed,) `xcode-select --install` and click Install on the popup.
2. `git clone git://github.com/An0nDev/Mocha && cd Mocha`
3. `./Build.sh`
4. `installer -package dist/Mocha.pkg -target /`

## Installing
Download and run `Mocha.pkg` from [the Releases page](https://github.com/An0nDev/Mocha/releases).

## Usage
Open `Mocha.app` from your `/Applications` folder. A tray icon will appear.

Click the button once to disable sleep (the "Caffeinate" label will change to "Decaffeinate"), and click it again to re-enable sleep (the "Decaffeinate" label will change back to "Decaffeinate").

Right-click (or two-finger-tap, depending on how you have your touchpad set up) the button to close the app. Note that the current sleep state is preserved after the application is closed.

## Uninstalling
Close Mocha first!

In a Terminal, run: `curl -fsSL https://raw.githubusercontent.com/An0nDev/Mocha/master/Uninstall.sh | sudo bash`.
Type your password when prompted.

The uninstallation is finished when you get the Terminal prompt back.

## Manually configuring the sleep state
To disable sleep: `sudo pmset -a disablesleep 1` in a Terminal, type password when prompted.

To enable sleep: `sudo pmset -a disablesleep 0` in a Terminal, type password when prompted.
