Travelpayouts Travel App iOS
=================
[![Travis](https://img.shields.io/travis/travelpayouts/travel-app-ios/master.svg)](https://travis-ci.com/travelpayouts/travel-app-ios)
#### Руководство [по-русски](https://github.com/travelpayouts/travel-app-ios/blob/master/README_RU.md)
## Description
[Travelpayouts](https://www.travelpayouts.com) Travel App iOS is an app template for flights and hotels search. When your user books flight or hotel, you get paid. Aviasales, Jetradar and Hotellook official apps are based on the same code.

You can use this template as a base for you application, or you can use it as is changing only the main settings (app title, color scheme, icon, etc).

To track statistics and payments, please visit our affiliate network website — [Travelpayouts.com](https://www.travelpayouts.com/).

To learn more about the Travelpayouts affiliate network, please visit [Travelpayouts FAQ](https://support.travelpayouts.com/hc/en-us/articles/203955613-Commission-and-payments).

## <a name="usage"></a>How to build your own app using the template project

### 📲 Setup

1. Download the latest release of template project (not beta) here: [https://github.com/travelpayouts/travel-app-ios/releases](https://github.com/travelpayouts/travel-app-ios/releases), file Source Code (zip).
Alternatively you can clone the repository for development.
2. Dependencies are managed via CocoaPods (cocoapods.org). It can be installed via Bundler.
The following installation commands should be executed in the project folder (unpacked zip archive or cloned repository):
  ```bash
  sudo gem install bundler
  bundle install --path vendor/bundle
  pod install --repo-update
  ```
  **Use the ```TravelpayoutsTravelApp.xcworkspace``` to work with your project**.
3. Add your partner's token and marker in ```TravelpayoutsTravelApp/default_config.plist``` file to parameters ```partner_marker``` and ```api_token```.
You can get the partner marker and API token on our website: [Travelpayouts](https://travelpayouts.com/).
4. AppStore app publishing requires unique app identifier (bundle id). It can be configured in Xcode.
![](https://github.com/travelpayouts/travel-app-ios/raw/master/readme_files/xcode_bundle_id.png)
5. Change app name in files ```Info.plist``` and ```LaunchScreen.xib```.
6. Use the ```default_config.plist``` config file to enable/disable flights/hotels tabs, to add app description, feedback email, app website link and App Store app link for the "About" page and to add localized values for external links.
7. Test the app on your iPhone/iPad or in Xcode simulator.
8. Publish the app via [App Store Connect](https://appstoreconnect.apple.com)

### 📱 iOS versions support
Application supports iOS 10.0 and higher

### 🖼 App Icon
**Do not forget to replace app icons** (Template project includes simple white icons by default). To do this you will need to replace icons in ```TravelpayoutsTravelApp/AppIcon.xcassets/AppIcon.appiconset``` folder (20.png, 29.png, 40.png etc) with your own icons with same names.

### ✈️🏨 Tab selection
If you want to remove flights or hotels search tab, change values of ```flights_enabled``` and ```hotels_enabled``` to NO in Project settings. Information tab can't be removed this way.

### 🔧🌻 Color customization
You can choose color scheme in ```ColorSchemeManager.swift``` file. Just add to ```current``` variable one of these values: BlackColorScheme() / PurpleColorScheme(). Or set CustomColorScheme() value and set up any color scheme you need in ```CustomColorScheme.swift``` file.
Here is a list of primary fields with explanations:

|Title|Description|
|--------|--------|
mainColor | Primary app color
actionColor | Actions highlight color

Fine-grained color customization can be configured in file ```ASTJRC.swift``` by overriding colors from the base class ```JRC```.

### 🤑 Appodeal ads setup
To get additional profit from ads, we've integrated Mobile Ads [Appodeal SDK](https://www.appodeal.com/) in the app. To configure it, specify the ```appodeal_key``` parameter in the ```default_config.plist``` file (get your API key by registering at [Appodeal](https://www.appodeal.com/)). Ads will appear on the waiting screens for tickets and hotels searching by default.

### ⭐️ Feedback
Set up the ```feedback_email``` and ```itunes_link``` parameters in ```default_config.plist``` file to activate "Contact us" and "Rate this app" links.
The recommended format for ```itunes_link``` is the following: ```https://itunes.apple.com/app/id1234567890?action=write-review```, where ```id1234567890``` is the identifier of a published application.

## 🏭 **Use of Firebase**
Template app supports **Firebase** services. To enable them, please connect your app in the Firebase console, download and copy with replacement the ```GoogleService-Info.plist``` file to ```TravelpayoutsTravelApp``` folder and switch the ```firebase_enabled``` flag to ```YES``` in the ```default_config.plist``` file. Out of the box there is an analytics support for: Search / Ticket opened / Ticket booked in the airlines part and Search / Hotel opened / Hotel booked in the hotels part of the app.
