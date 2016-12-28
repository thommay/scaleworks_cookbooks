include_recipe "chef-client::service"

service 'ntp' do
  action [:enable, :start]
  only_if { node['virtualization']['role'] == 'host' }
end

file "/opt/local/etc/pkgin/repositories.conf" do
  content <<-EOH
http://pkgsrc.scaleworks.io/All
https://pkgsrc.joyent.com/packages/SmartOS/2016Q3/x86_64/All
EOH
end

execute "pkgin -y up"
