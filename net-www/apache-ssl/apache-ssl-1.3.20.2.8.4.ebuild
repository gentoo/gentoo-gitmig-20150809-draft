# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/apache-ssl/apache-ssl-1.3.20.2.8.4.ebuild,v 1.1 2001/05/24 19:56:28 achim Exp $

AV="1.3.20"
MSV="2.8.4"

A="apache_${AV}.tar.gz mod_ssl-${MSV}-${AV}.tar.gz"
S=${WORKDIR}/apache_${AV}
DESCRIPTION="The Apache Web Server v1.3.19 with mod_ssl"
SRC_URI="http://httpd.apache.org/dist/httpd/apache_${AV}.tar.gz
	 ftp://ftp.modssl.org/source/mod_ssl-${MSV}-${AV}.tar.gz"
HOMEPAGE="http://www.apache.org http://www.modssl.org"

DEPEND="virtual/glibc
	=sys-libs/db-3.2.3h-r3
	=sys-libs/db-1.85-r1
	>=dev-libs/openssl-0.9.6"

src_compile() {                           
   export SSL_BASE=SYSTEM
#I get file locking errors with 2.4.0-test10 thru 12 (everything I've tried)
#so we zap the FLOCK option...
#	export EXTRA_CFLAGS="-DUSE_FLOCK_SERIALIZED_ACCEPT -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
	export EXTRA_CFLAGS="-D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
   cd ${S}/../mod_ssl-${MSV}-${AV}
    try ./configure --with-apache=${S} --with-ssl=SYSTEM
   cd ${S}
   export RULE_EXPAT=NO
   try ./configure --prefix=/usr/local/httpd --bindir=/usr/bin \
	--sbindir=/usr/sbin --datadir=/usr/local/httpd \
	--sysconfdir=/etc/httpd --libexecdir=/usr/lib/apache \
	--mandir=/usr/share/man --logfiledir=/var/log/apache --localstatedir=/var/lock \
	--proxycachedir=/var/cache/httpd --includedir=/usr/include/apache \
	--enable-module=all --enable-module=ssl \
	--enable-shared=max --enable-suexec --suexec-caller=wwwrun \
	--suexec-userdir=public_html --suexec-uidmin=96 \
	--suexec-gidmin=96 --suexec-safepath="/bin:/usr/bin" \
	--disable-rule=EXPAT
#	--disable-module=auth_dbm"
    try make
    try make certificate TYPE=dummy
}

src_install() { 
    try make install-quiet root=${D}
    cd ${D}/usr/sbin
    cp apachectl apachectl.orig
    sed -e "s:^PIDFILE.*:PIDFILE=/var/run/httpd.pid:" \
	apachectl.orig > apachectl
    rm apachectl.orig
    dodoc ABOUT_APACHE Announcement INSTALL* KEYS LICENSE* README* WARNING*
    docinto mod_ssl
    cd ../mod_ssl-${MSV}-${AV}
    dodoc ANNOUNCE CHANGES CREDITS INSTALL* LICENSE NEWS README*
    dodir /etc/rc.d/init.d
    cp ${FILESDIR}/httpd.conf ${D}/etc/httpd
    cp ${FILESDIR}/httpd ${D}/etc/rc.d/init.d
}

pkg_config() {

  source ${ROOT}/var/db/pkg/install.config
  source ${ROOT}/etc/rc.d/config/functions

  if [ "$ServerName" = "" ]
  then
    ServerName=`uname -n`
  fi
  if [ "$ServerAdmin" = "" ]

  then
    ServerAdmin="webmaster\@$ServerName"
  fi

  # Make apache start at boot
  ${ROOT}/usr/sbin/rc-update add httpd

  # Set ServerName and ServerAdmin
  einfo "Setting Servername to $ServerName..."
  cp ${ROOT}/etc/httpd/httpd.conf ${ROOT}/etc/httpd/httpd.conf.orig
  sed -e "s/^\#ServerName.*/ServerName $ServerName/" \
      -e "s/^ServerName.*/ServerName $ServerName/" \
      -e "s/^ServerAdmin.*/ServerAdmin $ServerAdmin/" \
	${ROOT}/etc/httpd/httpd.conf.orig > ${ROOT}/etc/httpd/httpd.conf

}

pkg_prerm() {

  source ${ROOT}/etc/rc.d/config/functions
  if [ "$ROOT" = "/" ] 
  then
    if [ -f /var/run/httpd.pid ]
    then
      einfo "Stopping running daemon..."
      /etc/rc.d/init.d/httpd stop
    fi
  fi

}

