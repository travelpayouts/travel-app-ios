Pod::Spec.new do |s|
  s.name         = "AviasalesKit"
  s.version      = "6.0"
  s.summary      = "Integrate flight search and booking framework in your apps."
  s.description  = <<-DESC
AviasalesKit iOS SDK is a framework integrating flights and hotels search engine into your app. When your user books a flight or hotel, you get paid. Framework is based on leading airline tickets and hotels search engines Aviasales.ru, Jetradar.com and Hotellook.com
                     DESC
  s.homepage     = "https://github.com/travelpayouts/travel-app-ios"
  s.license      = { :type => "Commercial" }
  s.author       = { "Aviasales iOS Team" => "support@aviasales.ru" }
  s.platform     = :ios, "10.0"
  s.source       = { :http => 'https://github.com/travelpayouts/travel-app-ios/releases/download/6.0/AviasalesKit.zip',
                     :sha1 => '8cb56c87a9811210f757f455bf0f9f98c7bea80b' }

  s.ios.vendored_frameworks = "Library/*.framework"
  s.ios.resources = ["Resources/*.bundle", "FileResources/*"]

end
