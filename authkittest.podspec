#
#  Be sure to run `pod spec lint PaymentKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = 'authkittest'
  s.version      = '0.0.0'
  s.summary      = 'AuthKit as cocoapod'
  s.swift_version    = "5"

  s.description  = <<-DESC
Provides cross-platform payments and gift cards functionality for client applications.
                       DESC

  s.homepage         = 'https://github.com/BajwaRevelAmeer/authkittest'
  s.license          = { :type => 'Commercial', :text => 'Revel Systems' }
  s.author           = { "Ameer Bajwa" => "ameer.bajwa@revelsystems.com" }
  
  s.source           = { :git => 'git@github.com:BajwaRevelAmeer/authkittest.git' }

  s.ios.deployment_target = '14.0'

  s.source_files     = 'authkittest/AuthKitCocoapod/AuthKitCocoapod/**/*'

  s.dependency      'Auth0',              '2.0.0'
  s.dependency      'SimpleKeychain',     '0.12.5' 
  s.dependency      'JWTDecode',          '2.6.3'

end
