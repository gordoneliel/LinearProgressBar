Pod::Spec.new do |s|
    s.name             = "LinearProgressBar"
    s.version          = "0.0.2"
    s.summary          = "LinearProgressBar is a simple bar control for iOS."

    s.description      = <<-DESC
    # LinearProgressBar
    # LinearProgressBar is a simple bar control for iOS.
    # What it does?
    # It can be used for tracking progress such as timing applications, progress indicators and more.
    # Just pod and start using the library
    DESC


    s.homepage         = "https://github.com/gordoneliel/LinearProgressBar"
    s.screenshots     = "https://github.com/gordoneliel/LinearProgressBar/blob/master/Promotional_images/hero.png"
    s.license          = 'MIT'
    s.author           = { "Eliel Gordon" => "gordoneliel@gmail.com" }
    s.source           = { :git => "https://github.com/gordoneliel/LinearProgressBar.git", :tag => s.version.to_s }
    s.social_media_url = 'https://facebook.com/gordoneliel'

    s.platform     = :ios, '8.0'
    s.requires_arc = true

    s.source_files = 'LinearProgressBar/**/*.{swift}'

    # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
