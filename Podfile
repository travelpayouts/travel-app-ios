source 'https://cdn.cocoapods.org/'

platform :ios, deployment_target: '11.0'
use_frameworks! :linkage => :static

install! 'cocoapods',
        share_schemes_for_development_pods: true,
        incremental_installation: true,
        generate_multiple_pod_projects: true

def aviasales_kit_dependencies
    pod 'AviasalesKit', podspec: 'https://ios.aviasales.ru/cocoapods/AviasalesKit_6.4.podspec'

    pod "CollectionSwipableCellExtension", git: 'https://github.com/KosyanMedia/CollectionSwipableCellExtension.git', commit: 'd3d7c9ee8721562174cbd2c89f88b1d05bbc5fc0'
    pod "SloppySwiper", git: 'https://github.com/glassoff/SloppySwiper.git', branch: 'aviasales'
    pod 'MagicalRecord', git: 'https://github.com/KosyanMedia/MagicalRecord.git', tag: 'v2.4.0-xcode12'
    pod 'Neon', git: 'https://github.com/KosyanMedia/Neon.git', commit: '3770df30ee072a728becb8f1f6b7c29276a3dab4'

    # suppress warnings
    pod 'TTTAttributedLabel', inhibit_warnings: true
    pod 'BZipCompression', inhibit_warnings: true
    pod 'GRMustache', inhibit_warnings: true
    pod 'PromiseKit', inhibit_warnings: true
    pod 'COSTouchVisualizer', inhibit_warnings: true
    pod 'SnowplowTracker', inhibit_warnings: true
end

target 'TravelpayoutsTravelApp' do
    aviasales_kit_dependencies

    pod 'Appodeal', '2.7.4'
    pod 'APDAmazonAdsAdapter', '2.7.4.1'
    # Enable following pods to use all available Interstitial ads
    # pod 'APDAppLovinAdapter', '2.7.4.1'
    # pod 'APDAppodealAdExchangeAdapter', '2.7.4.1'
    # pod 'APDChartboostAdapter', '2.7.4.1'
    # pod 'APDFacebookAudienceAdapter', '2.7.4.1'
    # pod 'APDGoogleAdMobAdapter', '2.7.4.1'
    # pod 'APDInMobiAdapter', '2.7.4.1'
    # pod 'APDInnerActiveAdapter', '2.7.4.1'
    # pod 'APDIronSourceAdapter', '2.7.4.1'
    # pod 'APDMyTargetAdapter', '2.7.4.1'
    # pod 'APDOguryAdapter', '2.7.4.1'
    # pod 'APDOpenXAdapter', '2.7.4.1'
    # pod 'APDPubnativeAdapter', '2.7.4.1'
    # pod 'APDSmaatoAdapter', '2.7.4.2'
    # pod 'APDStartAppAdapter', '2.7.4.1'
    # pod 'APDTapjoyAdapter', '2.7.4.1'
    # pod 'APDUnityAdapter', '2.7.4.1'
    # pod 'APDYandexAdapter', '2.7.4.1'

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
        apply_config = lambda do |config|
            if config.name.downcase =~ /^release/
                config.build_settings['SWIFT_COMPILATION_MODE'] = 'wholemodule'
            else
                config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
                config.build_settings['VALIDATE_PRODUCT'] = 'NO'
                config.build_settings['SWIFT_COMPILATION_MODE'] = 'singlefile'
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
                config.build_settings['ENABLE_TESTABILITY'] = 'YES'
                config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'DEBUG'
                config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
            end

            config.build_settings.delete('ARCHS')

            # TODO: remove this after migration to CocoaPods 1.10.0
            config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
        end
        project.build_configurations.each do |config|
            apply_config.call(config)
        end
        project.targets.each do |target|
            target.build_configurations.each do |config|
                apply_config.call(config)

                # workaround for Xcode 12 with CocoaPods 1.9.1
                if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] == '8.0'
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
                end
            end
        end
    end

    # fix GRMustache compilation with incremental cocoapods
    source_file = "Pods/GRMustache/src/classes/Rendering/GRMustacheKeyAccess.m"
    FileUtils.chmod "u+w", source_file
    contents = File.read(source_file)
    if contents.include? '#import "JRSwizzle.h"'
        contents = contents.gsub!('#import "JRSwizzle.h"', '#import <JRSwizzle/JRSwizzle.h>')
        File.open(source_file, "w") { |file| file.puts contents }
        FileUtils.chmod "u-w", source_file
    end
end
