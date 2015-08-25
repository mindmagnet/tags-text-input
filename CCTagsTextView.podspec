Pod::Spec.new do |s|
  s.name             = "CCTagsTextView"
  s.version          = "0.1.1"
  s.summary          = "Simple tags recogniser UITextView"
  s.description      = "Use this library in order to add an text view taht recognise tags prfixed by # and retuns them into an array."
  s.homepage         = "https://github.com/mindmagnet/tags-text-input"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Daniel Mandea" => "daniel.mandea@mindmagnetsoftware.com" }
  s.source           = { :git => "https://github.com/mindmagnet/tags-text-input.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/daniel.mandea'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CCTagsTextView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
