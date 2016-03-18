Pod::Spec.new do |s|
s.name         = "ProfilePicture"
s.version      = "0.0.1"
s.summary      = "Profile Picture made easy. Rounded by default and imagePicker already hooked up no stress no sweat."
s.license      = {:type => 'Commercial', :text => "Copyright (c) Dan Leonard. All rights reserved." }
s.author       = { "Dan Leonard" => "pdanielleonard@gmail.com" }
s.source       = { :git => "https://github.com/macmedan/ProfilePicture.git", :tag => s.version.to_s }
s.homepage     = "https://github.com/macmedan/ProfilePicture.git"
s.requires_arc = true

s.ios.deployment_target = '9.0'

end