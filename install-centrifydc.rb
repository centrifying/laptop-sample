# Variables (non-idempotent)

domain = 'centrify.vms'
zone = 'Global'
ou = 'ou=servers,ou=UNIX'
crole = 'App Servers'

# Installs Centrify DirectControl

package 'CentrifyDC'

# Retrieves utility files

remote_file '/tmp/krb5.conf' do
  source 'http://engcen6.centrify.vms/centrify/utils/krb5.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

remote_file '/tmp/ad-joiner.keytab' do
  source 'http://engcen6.centrify.vms/centrify/utils/ad-joiner.keytab'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Obtain a TGT using keytab
execute 'env' do
  command "env KRB5_CONFIG=/tmp/krb5.conf /usr/share/centrifydc/kerberos/bin/kinit -kt /tmp/ad-joiner.keytab ad-joiner"
end

# Join AD
execute 'adjoin' do
   command "/usr/sbin/adjoin -z #{zone} -c #{ou} -R \"#{crole}\" -V #{domain}"
end

# Install Audit Package (opt)

package 'CentrifyDA'

#  Cleanup
 file '/tmp/ad-joiner.keytab' do
    action :delete
  end

 file '/tmp/krb5.conf' do
       action :delete
 end
