Pod::Spec.new do |s|
  s.name             = 'NGLoggerKit'
  s.version          = '1.3'
  s.summary          = 'Logging system customizable and flex'
  s.description      = <<-DESC
  This logging library enable you to easily manage your logging systems. It also provides a default implementation which use XCGLogger as file logger and Apple's oslog for console logging.
                      DESC
  s.homepage         = 'https://github.com/nuglif/LoggerKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Team Nuglif' => 'alison@nuglif.com' }

  s.source           = { :git => 'https://github.com/nuglif/LoggerKit.git', :tag => s.version.to_s }
  s.source_files = [
      'Source/*.h',
      'Source/**/*.{h,m,mm,swift}'
  ]

  s.swift_version = '5.0'
  s.ios.deployment_target = '9.2'
  
  s.dependency 'XCGLogger', '~> 7.0'
end

