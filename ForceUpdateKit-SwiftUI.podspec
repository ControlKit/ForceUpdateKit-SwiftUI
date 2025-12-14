Pod::Spec.new do |spec|
  spec.name         = 'ForceUpdateKit-SwiftUI'
  spec.version      = '0.0.11'
  spec.summary      = 'A short description of ForceUpdateKit.'

  spec.license = 'MIT'
  spec.summary = 'The force update in all app is handled easily.'
  spec.homepage = 'https://github.com/ControlKit/ForceupdateKit-SwiftUI'
  spec.source = { :git => 'https://github.com/ControlKit/ForceupdateKit-SwiftUI.git', :tag => "#{spec.version}" }
  spec.ios.deployment_target = '13.0'
  spec.source_files = 'Sources/*.swift', 'Sources/**/*.swift', 'Sources/**/**/*.swift'
  spec.resources = 'Sources/ForceUpdateKit-SwiftUI/Resources/*.xcassets'
  spec.authors = { 'Maziar Saadatfar' => 'maziar.saadatfar@gmail.com' }
  spec.swift_versions = ['5.0']
end
