Pod::Spec.new do |s|

  s.name         = "MHNetworkingKit"
  s.version      = "1.1.0"
  s.source       = { :git => "https://github.com/KoCMoHaBTa/#{s.name}.git", :tag => "#{s.version}" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Milen Halachev"
  s.summary      = "A lightweight swift library that contains network related extension and tools, like Multipart Form Data, JSON and URL Encoding."
  s.homepage     = "https://github.com/KoCMoHaBTa/#{s.name}"

  s.swift_version = "5.0"
  s.ios.deployment_target = "8.0"

  s.source_files  = "#{s.name}/**/*.swift", "#{s.name}/**/*.{h,m}"
  s.public_header_files = "#{s.name}/**/*.h"

end
