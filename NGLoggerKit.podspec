Pod::Spec.new do |s|
  s.name             = 'NGLoggerKit'
  s.version          = '0.1'
  s.summary          = 'Logging system customizable and flex'

  s.description      = <<-DESC
  This logging library enable you to easily manage your logging systems. It also provides a default implementation which use XCGLogger as file logger and Apple's oslog for console logging.
                      DESC

  s.homepage         = 'https://github.com/nuglif/LoggerKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Team Nuglif' => 'awerck@nuglif.com' }
  s.source           = { :git => 'https://github.com/nuglif/LoggerKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.2'
  s.swift_version = '4.2'
  s.module_name = 'LoggerKit'
  s.exclude_files = 'LoggerKit_Sample/*'
  s.public_header_files = [
       'source/LoggerKit/*.h',
       'source/LoggerKit/**/*.h'
   ]
  s.source_files = [
      'source/LoggerKit/*.h',
      'source/LoggerKit/**/*.{h,m,mm,swift}'
  ]
  s.dependency 'XCGLogger'

end

