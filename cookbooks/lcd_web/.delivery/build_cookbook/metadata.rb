name 'build_cookbook'
maintainer 'Taras Berezovskyi'
maintainer_email 'taras.berezovskyi@globallogic.com'
license 'all_rights'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'delivery-truck'
