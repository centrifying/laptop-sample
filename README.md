# laptop-sample
This is a non-idempotent Chef recipe that works with my laptop demo

This is a simple recipe that:

1. Installs CentrifyDC from the local Yum repo in a centos6 system
2. Retrieves a krb5.conf and keytab
3. Joins Active Directory, A Centrify Zone and A Computer Role
4. Performs Cleanup


Requirements
Requires Chef Development Kit (ChefDK) for RHEL and derivatives
