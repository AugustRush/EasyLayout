Pod::Spec.new do |s|
  s.name = "EasyLayout"
  s.version = "0.5"
  s.summary = "This is an library for AutoLayout like Masonry but more, Just for fun and self-use."
  s.homepage = "https://github.com/ProfessionalIsFunny/EasyLayout"
  s.license = "MIT"
  s.authors = {'AugustRush' => 'liupingwei30@gmail.com'}
  s.platform = :ios, "6.0"
  s.source = {:git => "https://github.com/ProfessionalIsFunny/EasyLayout.git", :tag => s.version}
  s.source_files = 'EasyLayout', 'EasyLayout/**/*.{h,m}'
  s.requires_arc = true
end