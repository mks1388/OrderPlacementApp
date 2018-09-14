platform :ios, '9.0'
use_frameworks!

target 'OrderPlacementApp' do

pod 'RxSwift', '~> 4.0'
pod 'RxCocoa', '~> 4.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
        end
    end
end

