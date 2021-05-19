source 'https://cdn.cocoapods.org/'

platform :ios, deployment_target: '12.0'
use_frameworks! :linkage => :static

install! 'cocoapods',
        share_schemes_for_development_pods: true,
        incremental_installation: true,
        generate_multiple_pod_projects: true

def aviasales_kit_dependencies
    pod 'AviasalesKit', podspec: 'https://ios.aviasales.ru/cocoapods/AviasalesKit_6.5.podspec'

    pod "CollectionSwipableCellExtension", git: 'https://github.com/KosyanMedia/CollectionSwipableCellExtension.git', commit: 'd3d7c9ee8721562174cbd2c89f88b1d05bbc5fc0', inhibit_warnings: true
    pod "SloppySwiper", git: 'https://github.com/glassoff/SloppySwiper.git', branch: 'aviasales'
    pod 'Neon', git: 'https://github.com/KosyanMedia/Neon.git', commit: '3770df30ee072a728becb8f1f6b7c29276a3dab4', inhibit_warnings: true

    # suppress warnings
    pod 'TTTAttributedLabel', inhibit_warnings: true
    pod 'BZipCompression', inhibit_warnings: true
    pod 'GRMustache', inhibit_warnings: true
    pod 'PromiseKit', inhibit_warnings: true
    pod 'SnowplowTracker', inhibit_warnings: true
    pod 'lottie-ios', inhibit_warnings: true
    pod 'Alamofire', inhibit_warnings: true
    pod 'PhoneNumberKit', inhibit_warnings: true
end

target 'TravelpayoutsTravelApp' do
    aviasales_kit_dependencies

    pod 'Appodeal', '2.9.1'
    pod 'APDAmazonAdsAdapter', '2.9.1.1'
    # Enable following pods to use all available Interstitial ads
    # pod 'APDAppLovinAdapter', '2.9.1.2'
    # pod 'APDBidMachineAdapter', '2.9.1.3'
    # pod 'APDChartboostAdapter', '2.9.1.1'
    # pod 'APDFacebookAudienceAdapter', '2.9.1.2'
    # pod 'APDGoogleAdMobAdapter', '2.9.1.3'
    # pod 'APDInMobiAdapter', '2.9.1.1'
    # pod 'APDIronSourceAdapter', '2.9.1.2'
    # pod 'APDMintegralAdapter', '2.9.1.1'
    # pod 'APDMyTargetAdapter', '2.9.1.2'
    # pod 'APDOguryAdapter', '2.9.1.2'
    # pod 'APDSmaatoAdapter', '2.9.1.1'
    # pod 'APDStartAppAdapter', '2.9.1.2'
    # pod 'APDTapjoyAdapter', '2.9.1.1'
    # pod 'APDTwitterMoPubAdapter', '2.9.1.1'
    # pod 'APDUnityAdapter', '2.9.1.2'
    # pod 'APDYandexAdapter', '2.9.1.3'

    target 'TravelpayoutsTravelAppTests' do
        inherit! :search_paths
    end
end

target 'SampleFlightsApp' do
    aviasales_kit_dependencies

    target 'SampleFlightsAppTests' do
        inherit! :search_paths
    end
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                # workaround for xcode 12 warnings
                if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] == '8.0'
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
                end
            end
        end
    end

    # fix GRMustache compilation with incremental cocoapods
    source_file = "#{__dir__}/Pods/GRMustache/src/classes/Rendering/GRMustacheKeyAccess.m"
    FileUtils.chmod "u+w", source_file
    contents = File.read(source_file)
    if contents.include? '#import "JRSwizzle.h"'
        contents = contents.gsub!('#import "JRSwizzle.h"', '#import <JRSwizzle/JRSwizzle.h>')
        File.open(source_file, "w") { |file| file.puts contents }
        FileUtils.chmod "u-w", source_file
    end
end
