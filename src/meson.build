banana_sources = [
  'main.vala',
  'application.vala',
  'main-window.vala',
  'onboarding/onboarding-window.vala',
]

banana_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.4'),
]

banana_sources += gnome.compile_resources('banana-resources',
  'banana.gresource.xml',
  c_name: 'banana'
)

executable('banana', banana_sources,
  dependencies: banana_deps,
       install: true,
)
