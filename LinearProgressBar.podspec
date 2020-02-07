Pod::Spec.new do |s|
    s.name             = "LinearProgressBar"
    s.version          = "1.0.2"
    s.summary          = "LinearProgressBar is a simple progress bar control for iOS."

    s.description      = <<-DESC
    # LinearProgressBar
    # LinearProgressBar is a simple progress bar control for iOS.
    # What it does?
    # It can be used for tracking progress such as timing applications, progress indicators and more.
    # Just pod and start using the library
    DESC


    s.homepage         = "https://github.com/gordoneliel/LinearProgressBar"
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { "Eliel Gordon" => "gordoneliel@gmail.com" }
    s.source           = { :git => "https://github.com/gordoneliel/LinearProgressBar.git", :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/1gordoneliel'

    s.platform     = :ios, '10.0'
    s.requires_arc = true

    s.source_files = 'LinearProgressBar/**/*.{swift}'
end
