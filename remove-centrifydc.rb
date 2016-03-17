# Get utility files

remote_file '/tmp/krb5.conf' do
  source 'http://engcen6.centrify.vms/centrify-repo/utils/krb5.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

remote_file '/tmp/ad-joiner.keytab' do
  source 'http://engcen6.centrify.vms/centrify-repo/utils/ad-joiner.keytab'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Authenticate against AD using keytab

execute 'env' do
  command "env KRB5_CONFIG=/tmp/krb5.conf /usr/share/centrifydc/kerberos/bin/kinit -kt /tmp/ad-joiner.keytab ad-joiner"
end

# Leave the domain and remove the computer object

execute 'adleave' do
   command "/usr/sbin/adleave -r"
end

execute 'kdestroy' do
  command "env KRB5_CONFIG=/tmp/krb5.conf /usr/share/centrifydc/kerberos/bin/kdestroy"
end

# Removes Packages
package 'CentrifyDA' do
   action [:remove]
end

package 'CentrifyDC' do
   action [:remove]
end

# Cleanup
file '/tmp/ad-joiner.keytab' do
   action :delete
end

file '/tmp/krb5.conf' do
   action :delete
end
