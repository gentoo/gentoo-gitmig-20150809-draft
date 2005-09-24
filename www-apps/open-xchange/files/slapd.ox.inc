access to dn.base="" by * read
access to dn.base="cn=Subschema" by * read

# protect the userPassword attribute
access to attrs=userPassword,shadowLastChange 
  by dn="uid=root,ou=Users,ou=OxObjects,dc=gen-ux,dc=com" write
  by anonymous auth
  by self write
  by * none

# global address book
access to dn.subtree="o=AddressBook,ou=OxObjects,dc=gen-ux,dc=com"
  by group.exact="cn=AddressAdmins,o=AddressBook,ou=OxObjects,dc=gen-ux,dc=com" write
  by users read

# personal address book
access to dn.regex="^ou=addr,(uid=([^,]+),ou=Users,ou=OxObjects,dc=gen-ux,dc=com)$" attrs=children
  by dn.exact,expand="$1" write
access to dn.regex="^uid=([^,]+),ou=addr,(uid=([^,]+),ou=Users,ou=OxObjects,dc=gen-ux,dc=com)$" attrs=entry
  by dn.exact,expand="$2" write

# default rule allowing users full access to their own entries
access to attr=birthDay,cn,description,facsimileTelephoneNumber,gecos,givenName,homePhone,initials,l,labeledURI,mobile,o,ou,OXAppointmentDays,OXTaskDays,OXTimeZone,pager,postalCode,preferredLanguage,sn,st,street,telephoneNumber,title,userCountry
    by self write
    by users read

access to *
  by dn="uid=root,ou=Users,ou=OxObjects,dc=gen-ux,dc=com" write
  by * read

index uid,mailEnabled,cn,sn,givenname,lnetMailAccess,alias,loginDestination eq,sub
