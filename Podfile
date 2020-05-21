source 'https://cdn.cocoapods.org/'

platform :ios, deployment_target: '11.0'
use_frameworks! :linkage => :static

def aviasales_kit_dependencies
    pod 'AviasalesKit', podspec: 'https://ios.aviasales.ru/cocoapods/AviasalesKit_6.3.podspec'

    pod "CollectionSwipableCellExtension", git: 'https://github.com/KosyanMedia/CollectionSwipableCellExtension.git', commit: 'd3d7c9ee8721562174cbd2c89f88b1d05bbc5fc0'
    pod "SloppySwiper", git: 'https://github.com/glassoff/SloppySwiper.git', branch: 'aviasales'
    pod 'LDNetDiagnoService', git: 'https://github.com/KosyanMedia/LDNetDiagnoService_IOS.git', commit: '34eacdaa7767f95389b13998bef3fa9137edb2b1'
    pod 'libCurlPods', git: 'https://github.com/KosyanMedia/libCurlPods.git', tag: '7.60.3'
    pod 'MagicalRecord', git: 'https://github.com/magicalpanda/MagicalRecord.git', tag: 'v2.4.0'
    pod 'Neon', git: 'https://github.com/KosyanMedia/Neon.git', commit: '3f32f7a9276732dfa28c5e3886f2f95e76aa60c5', inhibit_warnings: true
    pod 'UIColor+Hex', git: 'https://github.com/KosyanMedia/UIColor-Hex.git', commit: 'df1248c06c11be7c67b7dd3227bff1113112e823'

    # suppress warnings
    pod 'TTTAttributedLabel', inhibit_warnings: true
    pod 'SwiftProtobuf', inhibit_warnings: true
    pod 'BZipCompression', inhibit_warnings: true
    pod 'FMDB', inhibit_warnings: true
    pod 'GRMustache', inhibit_warnings: true
    pod 'PromiseKit', inhibit_warnings: true
    pod 'COSTouchVisualizer', inhibit_warnings: true
end

target 'TravelpayoutsTravelApp' do
    aviasales_kit_dependencies

    pod 'Appodeal', '2.6.3'
    pod 'APDAmazonAdsAdapter', '2.6.3.1'
    # Enable following pods to use all available Interstitial ads
    # pod 'APDAppLovinAdapter', '2.6.3.1'
    # pod 'APDAppodealAdExchangeAdapter', '2.6.3.1'
    # pod 'APDChartboostAdapter', '2.6.3.1'
    # pod 'APDFacebookAudienceAdapter', '2.6.3.2'
    # pod 'APDGoogleAdMobAdapter', '2.6.3.1'
    # pod 'APDInMobiAdapter', '2.6.3.1'
    # pod 'APDInnerActiveAdapter', '2.6.3.1'
    # pod 'APDIronSourceAdapter', '2.6.3.1'
    # pod 'APDMintegralAdapter', '2.6.3.1'
    # pod 'APDMyTargetAdapter', '2.6.3.1'
    # pod 'APDOpenXAdapter', '2.6.3.1'
    # pod 'APDPubnativeAdapter', '2.6.3.1'
    # pod 'APDSmaatoAdapter', '2.6.3.1'
    # pod 'APDStartAppAdapter', '2.6.3.2'
    # pod 'APDTapjoyAdapter', '2.6.3.1'
    # pod 'APDUnityAdapter', '2.6.3.1'
    # pod 'APDYandexAdapter', '2.6.3.1'

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
                config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
                config.build_settings['VALIDATE_PRODUCT'] = 'NO'
                config.build_settings['SWIFT_COMPILATION_MODE'] = 'singlefile'
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
                config.build_settings['ENABLE_TESTABILITY'] = 'YES'
                config.build_settings['SWIFT_ACTIVE_COMPILATION_CONDITIONS'] = 'DEBUG'
                config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
            end
        end
        project.build_configurations.each do |config|
            apply_config.call(config)
        end
        project.targets.each do |target|
            target.build_configurations.each do |config|
                apply_config.call(config)
            end
        end
    end
end
