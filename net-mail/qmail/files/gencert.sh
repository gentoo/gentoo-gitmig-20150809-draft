umask 0077 ; 
/usr/bin/openssl genrsa -out /var/qmail/control/rsa512.new 512 >/dev/null 2>&1 && \
chown qmaild:qmail /var/qmail/control/rsa512.new && \
/bin/mv -f /var/qmail/control/rsa512.new /var/qmail/control/rsa512.pem 
