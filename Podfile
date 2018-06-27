source 'https://github.com/CocoaPods/Specs.git'

workspace 'TowSlip.xcworkspace'
project 'TowSlip.xcodeproj'

platform :ios, 9.0
use_frameworks!

target 'TowSlip' do
    pod 'MKDropdownMenu'
    pod 'THCalendarDatePicker'
	pod 'JVFloatLabeledTextField'
    pod 'SwiftyJSON', :git => 'https://github.com/acegreen/SwiftyJSON.git', :branch => 'swift3'
    pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git'
    pod 'ObjectMapper', :git => 'https://github.com/Hearst-DD/ObjectMapper.git'
    pod 'CTAssetsPickerController',  '~> 3.3.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
