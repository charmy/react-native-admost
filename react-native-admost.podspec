require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-admost"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.license      = package['license']
  s.authors      = package['author']
  s.homepage     = package['homepage']
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/up-inside/react-native-admost.git", :tag => "#{s.version}" }
  s.source_files = "ios/**/*.{h,c,m,swift}"

  s.dependency "React"
  s.dependency "AMRSDK", "~> 1.4"
  s.dependency "AMRAdapterAdmob", "~> 7.65"
  s.dependency "AMRAdapterAdmost", "~> 1.3"
  s.dependency 'AMRAdapterFacebook', '~> 5.10'

end