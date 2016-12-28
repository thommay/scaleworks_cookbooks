package "libidn"

package "exim" do
  action :upgrade
  notifies :restart, "service[exim]"
end

service "exim" do
  action :enable
end

cookbook_file "/etc/aliases"

cookbook_file "/etc/mailer.conf"

directory "/opt/local/etc/exim" do
  recursive true
end

template "/opt/local/etc/exim/configure" do
  variables node['exim']['configuration']
  verify "exim -C %{path} -bV"
  notifies :restart, "service[exim]"
end
