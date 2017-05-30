# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'OompaLoompa' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OompaLoompa
  pod 'OompaLoompaCore',    :path => 'Frameworks/OompaLoompaCore'
  pod 'NVActivityIndicatorView', :inhibit_warnings => true
  pod 'HanekeSwift', :git => 'https://github.com/Haneke/HanekeSwift.git', :commit => '74f34c1c1845907927de5e71ea621399c1f603e0'
  
  target 'OompaLoompaTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'FBSnapshotTestCase'
  end

  target 'OompaLoompaUITests' do
    inherit! :search_paths
    # Pods for testing
  end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

end
