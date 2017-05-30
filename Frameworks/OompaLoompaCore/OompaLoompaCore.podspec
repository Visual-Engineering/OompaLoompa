Pod::Spec.new do |spec|
  spec.name     = 'OompaLoompaCore'
  spec.version  = '0.1.0'
  spec.summary  = 'Oompa Loompa Core Kit'
  spec.homepage = 'https://github.com/Visual-Engineering'
  spec.license  = { type: 'Apache License, Version 2.0', file: 'LICENSE' }
  spec.authors  = { 'Visual-Engineering' => 'ios@visual-engin.com' }

  spec.platform     = :ios, '10.0'
  spec.framework    = 'Foundation'
  spec.requires_arc = true
  spec.source_files = '**/*.{h,m,swift}'
  spec.source       = { :path => '.' }
  spec.dependency 'BSWFoundation'
  spec.dependency 'RealmSwift'

end
