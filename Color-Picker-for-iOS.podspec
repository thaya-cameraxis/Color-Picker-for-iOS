Pod::Spec.new do |s|
  s.name         = "Color-Picker-for-iOS"
  s.version      = "2.0.3.private"
  s.summary      = "ColorPicker for iPhone and iPod touch"
  s.homepage     = 'https://github.com/hayashi311/Color-Picker-for-iOS'
  s.license      = { :type => 'new BSD License', :file => 'LICENSE.txt' }
  s.author       = { "hayashi311" => "hayashi311@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/thaya-cameraxis/Color-Picker-for-iOS.git", :commit => '2ac1cd8a8d1d92800636e8817d5f94e02b4264a3' }
  s.source_files  = "HRColorPicker/**/*.{h,m}"
  s.requires_arc = true
end
