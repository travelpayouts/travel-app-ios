source 'https://github.com/CocoaPods/Specs.git'

platform :ios, :deployment_target => '10.0'
inhibit_all_warnings!
use_frameworks!

def hl_sdk_pods
    pod 'Alamofire'
    pod "KeychainSwift"
    pod "SwiftProtobuf", '1.2.0'
end

def hl_shared_pods
    pod 'Smartling.i18n'
    pod 'SDWebImage'
    pod 'Amplitude-iOS'
end

def hl_ui_pods
    pod 'Neon', git: 'https://github.com/MontakOleg/Neon.git', commit: '3f32f7a9276732dfa28c5e3886f2f95e76aa60c5'
    pod 'UIColor+Hex', git: 'https://github.com/MontakOleg/UIColor-Hex.git', commit: 'df1248c06c11be7c67b7dd3227bff1113112e823'
    pod 'Smartling.i18n'
    pod 'SDWebImage'
end

def hl_host_pods
    hl_shared_pods
    hl_ui_pods
    pod 'Flurry-iOS-SDK/FlurrySDK'
    magical_record
    pod 'UIView+Shake'
    pod 'COSTouchVisualizer'
    pod 'BZipCompression'
    pod 'ReachabilitySwift'
    pod 'FBSDKCoreKit', '~> 4.35.0'
    pod 'FBSDKShareKit', '~> 4.35.0'
    pod 'ClusterKit/MapKit'
    pod 'PureLayout'
    pod 'PromiseKit', '~> 6.4'
    pod "CollectionSwipableCellExtension", git: 'https://github.com/KosyanMedia/CollectionSwipableCellExtension.git', tag: '0.0.3'
    pod "MBProgressHUD"
    pod 'SnowplowTracker', '~> 1.0.4'
end

def magical_record
    pod 'MagicalRecord', :git => 'https://github.com/stury/MagicalRecord.git', commit: '496e74838742fd5ea44dbafdfbf844ac998eeae4'
end

def shared_pods
    pod 'AppsFlyerFramework'
    pod 'Crashlytics'
    pod 'Flurry-iOS-SDK/FlurrySDK'
    pod 'GoogleConversionTracking'
    pod 'GoogleTagManager',         '~> 3.15'
    pod 'GRMustache',                               :inhibit_warnings => true
    magical_record
    pod 'SDWebImage'
    pod 'Smartling.i18n'
    pod 'LDNetDiagnoService', git: 'https://github.com/KosyanMedia/LDNetDiagnoService_IOS.git', commit: '34eacdaa7767f95389b13998bef3fa9137edb2b1'
    pod 'Firebase/Core'
    pod "lottie-ios", '~> 2.5.3'       # v3.0 doesn't have obj-c support
    pod "MBProgressHUD"
    pod "TTTAttributedLabel"
    pod "YYKeyboardManager"
    pod "JVFloatLabeledTextField"
    pod "PhoneNumberKit"
    pod "1PasswordExtension"
    pod "UIDevice-Hardware"
    pod "DynamicBlurView"
    pod "AutoCoding"
    pod "PureLayout"
    pod 'FBSDKCoreKit', '~> 4.35.0'
    pod 'Amplitude-iOS'
    pod 'ReachabilitySwift'
    pod 'BZipCompression'
    pod 'ClusterKit/MapKit'
    pod "CollectionSwipableCellExtension", git: 'https://github.com/KosyanMedia/CollectionSwipableCellExtension.git', tag: '0.0.3'
    pod "DGCollectionViewLeftAlignFlowLayout"
    pod 'libCurlPods', git: 'https://github.com/KosyanMedia/libCurlPods.git', tag: '7.60.2'
    pod "SloppySwiper", git: 'https://github.com/glassoff/SloppySwiper.git', branch: 'aviasales'
    hl_sdk_pods
end

target 'TravelpayoutsTravelApp' do
    shared_pods
    hl_host_pods

    pod 'AviasalesKit', podspec: 'https://github.com/travelpayouts/travel-app-ios/raw/6.0/AviasalesKit.podspec'

    pod 'Fabric'
    pod 'Crashlytics'
    pod 'Appodeal/Interstitial', '2.4.10'

    target 'TravelpayoutsTravelAppTests' do
        inherit! :search_paths
    end
end

pre_install do |installer|
    installer.analysis_result.specifications.each do |spec|
        spec.root.static_framework = true
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name.downcase =~ /^release/
                config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule'
            else
                config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
                config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
                config.build_settings['VALIDATE_PRODUCT'] = 'NO'
                config.build_settings['SWIFT_COMPILATION_MODE'] = 'singlefile'
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
                config.build_settings['ENABLE_TESTABILITY'] = 'YES'
                config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'DEBUG'
                config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
            end
        end
    end
end
