Pod::Spec.new do |s|
  s.name             = "CCTagsTextView"
  s.version          = "0.2.2"
  s.summary          = "Simple tags recogniser input view using UITextView"
  s.description      = <<-DESC
                        Use this library in order to add an text view taht recognise tags prfixed by
                        # and retuns them into an array.
                        This is similar to facebook tags recogniser.
                     DESC
  s.homepage         = "https://github.com/mindmagnet/tags-text-input"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Daniel Mandea" => "daniel.mandea@mindmagnetsoftware.com" }
  s.source           = { :git => "https://github.com/mindmagnet/tags-text-input.git", :tag => "0.2.2" }
  s.social_media_url = 'https://twitter.com/MandeaDaniel'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
# s.resource_bundles = {
#   'CCTagsTextView' => ['Pod/Assets/*.png']
# }
  s.source_files = 'Pod/Classes/**/*'

end
