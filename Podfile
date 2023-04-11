source 'https://cdn.cocoapods.org/'
source 'https://github.com/appodeal/CocoaPods.git'

platform :ios, deployment_target: '13.0'
use_frameworks! :linkage => :static

install! 'cocoapods',
        share_schemes_for_development_pods: true,
        incremental_installation: true,
        generate_multiple_pod_projects: true

def aviasales_kit_dependencies
    pod 'AviasalesKit', podspec: 'https://ios.aviasales.ru/cocoapods/AviasalesKit_6.7.podspec'

    pod 'EasyTipView', git: 'https://github.com/KosyanMedia/EasyTipView.git', commit: 'ab95be17ce90ff163569e50e2e2b659f003d80a4'
    pod "CollectionSwipableCellExtension", git: 'https://github.com/KosyanMedia/CollectionSwipableCellExtension.git', commit: 'd3d7c9ee8721562174cbd2c89f88b1d05bbc5fc0'
    pod 'Neon', git: 'https://github.com/KosyanMedia/Neon.git', commit: '3770df30ee072a728becb8f1f6b7c29276a3dab4'
end

def google_utilites
  pod 'GoogleUtilities'
end

target 'TravelpayoutsTravelApp' do
    google_utilites
    aviasales_kit_dependencies

    pod 'APDBidMachineAdapter', '3.1.0.1' # Required
    pod 'APDAmazonAdsAdapter', '3.1.0.1'
    # Enable following pods to use all available Interstitial ads
    # pod 'APDAppLovinAdapter', '3.1.0.1'
    # pod 'APDFacebookAudienceAdapter', '3.1.0.1'
    # pod 'APDGoogleAdMobAdapter', '3.1.0.1'
    # pod 'APDIronSourceAdapter', '3.1.0.1'
    # pod 'APDMyTargetAdapter', '3.1.0.1'
    # pod 'APDOguryAdapter', '3.1.0.1'
    # pod 'APDUnityAdapter', '3.1.0.1'
    # pod 'APDYandexAdapter', '3.1.0.1'

    target 'TravelpayoutsTravelAppTests' do
        inherit! :search_paths
    end
end

target 'SampleFlightsApp' do
    google_utilites
    aviasales_kit_dependencies

    target 'SampleFlightsAppTests' do
        inherit! :search_paths
    end
end

inhibit_warnings_pods = Set.new [
    'Neon',
    'CollectionSwipableCellExtension',
    'BZipCompression',
    'PromiseKit',
    'SnowplowTracker',
    'lottie-ios',
    'PhoneNumberKit',
    'Apollo',
]

pre_install do |installer|
    installer.analysis_result.pod_targets.each do |target|
        # suppress warnings
        if inhibit_warnings_pods.include? target.pod_name
            target.instance_variable_set(:@inhibit_warnings, true)
        end
    end
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                # workaround for xcode warnings
                if Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET']) < Gem::Version.new('11.0')
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
                end
                # workaround for build errors when using a Pod with BUILD_LIBRARY_FOR_DISTRIBUTION
                config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
            end
        end

        project.build_configurations.each do |config|
            # workaround for M1. remove when all pods support M1
            config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = %w(arm64)
        end

        # set we checked Xcode 13 recommended settings
        # how it works: https://lapcatsoftware.com/articles/validate-project-settings-never.html
        project.root_object.attributes['LastUpgradeCheck'] = '1420'
        Dir.glob("#{project.path}/**/*\.xcscheme").each do |scheme_path|
            scheme = Xcodeproj::XCScheme.new(scheme_path)
            scheme.doc.root.attributes['LastUpgradeVersion'] = '1420'
            scheme.save!
        end
    end
end
