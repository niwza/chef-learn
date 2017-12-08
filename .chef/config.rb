current_dir = File.dirname(__FILE__)
cookbook_path             ["#{current_dir}/../cookbooks"]
#local_mode true
log_level                 :info
log_location              STDOUT
node_name                 "chefadmin"
client_key                "#{current_dir}/chefadmin.pem"
chef_server_url           "https://chef-server/organizations/testcheflab"

if File.basename($PROGRAM_NAME).eql?('chef') && ARGV[0].eql?('generate')
  chefdk.generator.license = "all_rights"
  chefdk.generator.copyright_holder = "Taras Berezovskyi"
  chefdk.generator.email = "taras.berezovskyi@globallogic.com"
  chefdk.generator_cookbook = "#{current_dir}/../generator/lcd_origin"
end
